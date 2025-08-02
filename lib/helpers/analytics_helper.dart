import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AnalyticsHelper {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Cache device and app info to avoid fetching it with every event.
  Map<String, dynamic>? _baseInfo;

  AnalyticsHelper() {
    _initBaseInfo();
  }

  Future<void> _initBaseInfo() async {
    _baseInfo = await _fetchBaseInfo();
  }

  Future<Map<String, dynamic>> _fetchBaseInfo() async {
    try {
      String unknown = "Unknown";
      String os = unknown,
          osVersion = unknown,
          device = unknown,
          app = unknown;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        os = "android";
        osVersion =
        "${androidInfo.version.codename} (${androidInfo.version.sdkInt.toString()})";
        device = "${androidInfo.brand} ${androidInfo.model}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        os = "iOS";
        osVersion = "${iosInfo.systemName} ${iosInfo.systemVersion}";
        device = "${iosInfo.utsname.machine} ${iosInfo.utsname.release}";
      }

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      return {
        "language": Platform.localeName,
        'os': os,
        'os_version': osVersion,
        'device': device,
        'app_name': packageInfo.appName,
        'package_name': packageInfo.packageName,
        'app_version': packageInfo.version,
      };
    } catch(exception){
      CustomLog.error(this, "Impossible to fetchBaseInfo", exception);
      return {"" : ""};
    }
  }

  Future<void> logLogin({String loginMethod = "email"}) async {
    try {
      _baseInfo ??= await _fetchBaseInfo();
      await _analytics.logLogin(
          loginMethod: loginMethod,
          parameters: {
            ...?_baseInfo,
            // Spread operator to include base info in the parameters
          }
      );
      CustomLog.info(this, "Logged login method : $loginMethod");
    } catch(exception){
      CustomLog.error(this, "Impossible to Log Login - loginMethod : $loginMethod", exception);
    }
  }

  Future<void> logSignUp(String signUpMethod) async {
    try {
      _baseInfo ??= await _fetchBaseInfo();
      await _analytics.logSignUp(
          signUpMethod: signUpMethod,
          parameters: {
            ...?_baseInfo,
            // Spread operator to include base info in the parameters
          }
      );
      CustomLog.info(this, "Logged signUp method : $signUpMethod");
    } catch(exception){
      CustomLog.error(this, "Impossible to Log SignUp - signUpMethod : $signUpMethod", exception);
    }
  }

  Future<void> logEvent(String eventName, [Map<String, dynamic>? parameters]) async {
    try {
      _baseInfo ??= await _fetchBaseInfo();
      await _analytics.logEvent(
        name: eventName,
        parameters: {
          ...?_baseInfo,
          // Spread operator to include base info in the parameters
          ...?parameters
          // Additional specific parameters
        },
      );
      CustomLog.info(this, "Logged event: with event name $eventName");
    } catch(exception){
      CustomLog.error(this, "Impossible to Log Event - eventName: $eventName", exception);
    }
  }

  // TODO - Test base info not erasing data
  Future<void> logSelectContent(String contentType, [String? itemName, String? itemId]) async {
    try {
      _baseInfo ??= await _fetchBaseInfo();
      // TODO - item id not visible in GA4
      await FirebaseAnalytics.instance.logEvent(
        name: "select_content",
        parameters: {
          ...?_baseInfo,
          "content_type": itemName ?? "",
          "item_name": itemName ?? "",
          "item_id": itemId ?? ""
        },
      );
      CustomLog.info(this, "Logged Select content $itemId - $itemName - $contentType");
    } catch(exception){
      CustomLog.error(this, "Impossible to Log Select content - contentType: $contentType", exception);
    }
  }

  Future<void> logScreenView(String screenName, [String? screenClass]) async {
    try {
      _baseInfo ??= await _fetchBaseInfo();
      await _analytics.logScreenView(
          screenName: screenName,
          screenClass: screenClass ?? screenName,
          parameters: {
            ...?_baseInfo
            // Spread operator to include base info in the parameters
          }
      );
      CustomLog.info(this, "Logged screen view: $screenName'");
    } catch(exception){
      CustomLog.error(this, "Impossible to Log screen view - screenName: $screenName", exception);
    }
  }

}
