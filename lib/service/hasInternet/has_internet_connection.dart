import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

class HasInternetConnection {

  static bool isInternet = false;
  List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  final Connectivity connectivity = Connectivity();
  final Dio _dio = Dio();

  /// Check internet connection continues
  Future<void> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult = (await (connectivity.checkConnectivity()));
    try {
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        isInternet = await _internetAvailable();
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        isInternet = await _internetAvailable();
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        isInternet = await _internetAvailable();
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        isInternet = await _internetAvailable();
      } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
        isInternet = await _internetAvailable();
      } else if (connectivityResult.contains(ConnectivityResult.other)) {
        isInternet = await _internetAvailable();
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        isInternet = await _internetAvailable();
      }else{
        isInternet = await _internetAvailable();
      }
      connectivitySubscription = connectivity.onConnectivityChanged.listen(_internetStream);
    } catch (e) {
      CustomLog.error(this, "HasInternetConnection :", e);
    }
  }

  Future<void> _internetStream(List<ConnectivityResult> result) async {
    connectionStatus = result;
    checkConnectivity();
  }

  Future<bool> _internetAvailable() async {
    try {
      final response = await _dio.get('https://dart.dev');
      return (response.statusCode == 200);
    } catch (e) {
      return false;
    }
  }

}




