import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/data/network/api_service.dart';
import 'package:flutter_mvvm_bloc_cubit/data/network/api_urls.dart';
import 'package:flutter_mvvm_bloc_cubit/features/authentication/api_request/login_api_request.dart';
import 'package:flutter_mvvm_bloc_cubit/features/authentication/model/login_model.dart';

class LoginService {
  final ApiService _apiService;
  LoginService(this._apiService);

  // Login Service
  Future<Result<LoginModel>> login(LoginApiRequest request) async {
    try {
      final url = ApiUrls.login;
      final result = await _apiService.post(url, body: request.toJson());
      if (result is Success) {
        final data=  LoginModel.fromJson(result.value);
        return  Success(data) ;
      } else if (result is Error) {
        return Error(result.type);
      } else {
        return Error(GenericError());
      }
    } catch(e) {
      return Error(DeserializationError());
    }
  }

}