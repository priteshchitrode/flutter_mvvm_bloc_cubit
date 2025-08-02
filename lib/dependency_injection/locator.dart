import 'package:dio/dio.dart';
import 'package:flutter_mvvm_bloc_cubit/data/network/api_service.dart';
import 'package:flutter_mvvm_bloc_cubit/data/storage/secured_shared_preferences.dart';
import 'package:flutter_mvvm_bloc_cubit/helpers/analytics_helper.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

void initLocator() {
  try {
    CustomLog.info(locator, "Registering services with GetIt...");

    // Shared Manager
    locator.registerLazySingleton(() => const FlutterSecureStorage());
    locator.registerLazySingleton(() => SecuredSharedPreferences(locator<FlutterSecureStorage>()));

    // Firebase
    locator.registerLazySingleton(() => AnalyticsHelper());

    // Auth Services
    locator.registerLazySingleton<Dio>(() => Dio());
    locator.registerLazySingleton(() => ApiService(locator<Dio>(), locator<SecuredSharedPreferences>()));

    CustomLog.info(locator, "All instances registered.");
  } catch (e) {
    CustomLog.error(locator, "ERROR : All instances are not registered.", e);
  }

}