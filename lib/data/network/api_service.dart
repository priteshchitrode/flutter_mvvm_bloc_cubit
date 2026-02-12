import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/data/network/api_urls.dart';
import 'package:flutter_mvvm_bloc_cubit/data/storage/secured_shared_preferences.dart';
import 'package:flutter_mvvm_bloc_cubit/service/has_internet_connection.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

class ApiService {
  final Duration _timeout = const Duration(seconds: 30); // General timeout for all requests
  final Dio _dio;
  final SecuredSharedPreferences _secureSharedPrefs;
  late DioCacheManager _cacheManager;
  ApiService(this._dio, this._secureSharedPrefs) {
    CacheConfig cacheConfig = CacheConfig(baseUrl: ApiUrls.baseUrl);
    _cacheManager = DioCacheManager(cacheConfig);
    _dio.interceptors.add(_cacheManager.interceptor);
    _dio.options.connectTimeout = _timeout.inMilliseconds;
    _dio.options.receiveTimeout = _timeout.inMilliseconds;
  }

  // Header
  Future<Map<String, String>> _getHeaders({bool isMultipart = false}) async {
    final username = dotenv.env["API_BASIC_AUTH_USERNAME"];
    final password = dotenv.env["API_BASIC_AUTH_PASSWORD"];

    if (username == null || password == null) {
      throw Exception("Missing API credentials in environment variables");
    }

    final basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return {
      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
      'Accept': 'application/json',
      'Authorization': basicAuth,
    };
  }

  // Clear Cache
  Future<void> clearCache() async {
    CustomLog.info(this, "Cache cleared successfully");
    await _cacheManager.clearAll();
  }

  // Generate Cache
  Future<String> _generateCacheKey(String url, Map<String, dynamic>? queryParams) async {
    var queryParamsString = queryParams != null ? base64.encode(utf8.encode(json.encode(queryParams))) : "";
    return "$url-$queryParamsString";
  }

  /// Get Api Method
  Future<Result<dynamic>> get(String url, {Map<String, dynamic>? queryParams, bool forceRefresh = false, CancelToken? cancelToken}) async {
    try {
      CustomLog.debug(this, "\nMethod : Get, \nURL : $url,n\,QueryParams : $queryParams");
      if (HasInternetConnection.isInternet != true) {
        return Error(InternetNetworkError());
      }
      String cacheKey = await _generateCacheKey(url, queryParams);
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        cancelToken: cancelToken,
        options: buildConfigurableCacheOptions(
          options: Options(headers: await _getHeaders()),
          maxAge: const Duration(minutes: 30),
          maxStale: const Duration(days: 1),
          subKey: cacheKey,
          forceRefresh: forceRefresh,
        ),
      );
      return _handleBodyResponse(response);
    } on DioError catch (dioError) {
      return _handleDioError(dioError);
    } catch (exception) {
      CustomLog.error(this, "Generic HTTP call error", exception);
      return Error(GenericError());
    }
  }

  /// Post Api Method
  Future<Result<dynamic>> post(String url, {dynamic body, Map<String, dynamic>? queryParams}) async {
    try {
      Object prettyBodyString;
      if (queryParams != null) {
        prettyBodyString = const JsonEncoder.withIndent('  ').convert(queryParams);
      } else {
        prettyBodyString = const JsonEncoder.withIndent('  ').convert(body);
      }
      CustomLog.debug(this, "\nMethod: Post \nURL: $url \nRequest: $prettyBodyString");
      if (!HasInternetConnection.isInternet) {
        return Error(InternetNetworkError());
      }
      final response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: await _getHeaders(), sendTimeout: _timeout.inMilliseconds, receiveTimeout: _timeout.inMilliseconds),
      );
      return _handleBodyResponse(response);
    } on DioError catch (dioError) {
      return _handleDioError(dioError);
    } catch (exception) {
      CustomLog.error(this, "Generic HTTP call error", exception);
      return Error(GenericError());
    }
  }

  /// Delete Api Method
  Future<Result<dynamic>> delete(String url) async {
    try {
      CustomLog.debug(this, "Method: Delete, URL: $url");
      if (!HasInternetConnection.isInternet) {
        return Error(InternetNetworkError());
      }
      final response = await _dio.delete(
        url,
        options: Options(headers: await _getHeaders(), sendTimeout: _timeout.inMilliseconds, receiveTimeout: _timeout.inMilliseconds),
      );
      return _handleBodyResponse(response);
    } on DioError catch (dioError) {
      return _handleDioError(dioError);
    } catch (exception) {
      CustomLog.error(this, "Generic HTTP call error", exception);
      return Error(GenericError());
    }
  }

  /// Multi parts
  Future<Result<dynamic>> multipart(String url, dynamic files, {Map<String, String>? fields, String? pathName}) async {
    try {
      final prettyFieldsString = const JsonEncoder.withIndent('  ').convert(fields);
      CustomLog.debug(this, "\nMethod : Multipart \nURL : $url \nPath name : $pathName \nFiles : $files \nFields : $prettyFieldsString");

      if (!HasInternetConnection.isInternet) {
        return Error(InternetNetworkError());
      }

      FormData formData = FormData();

      // Handling file upload (single or multiple)
      if (files != null) {
        if (files is List<File>) {
          for (var file in files) {
            if (await file.exists()) {
              formData.files.add(MapEntry(pathName ?? "file", await MultipartFile.fromFile(file.path)));
            } else {
              CustomLog.debug(this, "File not found: ${file.path}");
            }
          }
        } else if (files is File) {
          if (await files.exists()) {
            formData.files.add(MapEntry(pathName ?? "file", await MultipartFile.fromFile(files.path)));
          } else {
            CustomLog.debug(this, "File not found: ${files.path}");
          }
        } else {
          return Error(ErrorWithMessage(message: "Invalid file type provided."));
        }
      }

      // Adding extra form fields if provided
      if (fields != null && fields.isNotEmpty) {
        formData.fields.addAll(fields.entries);
      }

      debugPrint("Form Data : ${formData.fields.toString()}");
      debugPrint("Form Data files : ${formData.files.toString()}");

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: await _getHeaders(isMultipart: true),
          sendTimeout: _timeout.inMilliseconds,
          receiveTimeout: _timeout.inMilliseconds,
        ),
      );
      return _handleBodyResponse(response);
    } on DioError catch (dioError) {
      return _handleDioError(dioError);
    } catch (exception) {
      CustomLog.error(this, "HTTP call error during multipart", exception);
      return Error(ErrorWithMessage(message: "$exception"));
    }
  }

  // Handle Body Response
  Result<dynamic> _handleBodyResponse(Response response) {
    try {
      final prettyBodyString = const JsonEncoder.withIndent('  ').convert(response.data);
      CustomLog.debug(this, "\nResponse status code: ${response.statusCode}, \nResponse data: $prettyBodyString");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(response.data);
      } else {
        return _handleHttpError(response);
      }
    } on Exception catch (e) {
      CustomLog.error(this, "Error decoding data response: $e", null);
      return Error(GenericError());
    }
  }

  // Handel HTTP Error
  Result<dynamic> _handleHttpError(Response? response) {
    switch (response?.statusCode) {
      case 400:
        return Error(ErrorWithMessage.fromApiResponse(response?.data));
      case 401:
        return Error(UnauthenticatedError());
      case 404:
        return Error(NotFoundError());
      case 409:
        return Error(ConflictError());
      case 498:
        return Error(InvalidTokenError());
      case 500:
        return Error(InternalServerError());
      default:
        log("Unexpected status code: ${response?.statusCode}");
        return Error(GenericError());
    }
  }

  // Handle Dio Error
  Result<dynamic> _handleDioError(DioError error) {
    CustomLog.error(this, "DIO HTTP call error,Status Code : ${error.response?.statusCode} response : ${error.response}", error);
    switch (error.type) {
      case DioErrorType.response:
        return _handleHttpError(error.response);
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return Error(NetworkTimeoutError());
      default:
        return Error(ErrorWithMessage(message: error.response?.data));
    }
  }

  // Json to Query Params
  String jsonToQueryParams(Map<String, dynamic> json) {
    String stringQueryParams = "";
    try {
      return json.entries
          .map((e) {
            final key = Uri.encodeComponent(e.key);
            final value = Uri.decodeComponent(e.value.toString());
            stringQueryParams = '$key=$value';
            return stringQueryParams;
          })
          .join('&');
    } catch (e) {
      CustomLog.error(this, "QueryParams : $stringQueryParams,\nRun type : ${stringQueryParams.runtimeType}", e);
      return stringQueryParams;
    }
  }

  String decodeQueryParams(String queryString) {
    return Uri.splitQueryString(queryString).entries.map((e) {
          final key = e.key;
          final value = Uri.decodeComponent(e.value); // Decode percent-encoded values
          return '$key = $value';
        }).join('\n');
  }

  /// Get Response Result Status
  Future<Result<T>> getResponseStatus<T>(dynamic result, T Function(dynamic) fromJson) async {
    if (result[STATUS] == true) {
      final data = fromJson(result);
      return Success(data);
    } else if (result[STATUS] == false) {
      return Error(ErrorWithMessage(message: result[MESSAGE]));
    } else {
      return Error(ResponseStatusFailed());
    }
  }

}
