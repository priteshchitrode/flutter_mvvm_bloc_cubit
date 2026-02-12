import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

/// Utility class to monitor and verify internet connectivity status.
class HasInternetConnection {

  /// Global flag indicating whether internet is available.
  static bool isInternet = false;

  /// Stores the current connectivity status list.
  List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];

  /// Subscription to listen for connectivity changes.
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  /// Connectivity instance to check network type.
  final Connectivity connectivity = Connectivity();

  /// Dio instance used to verify actual internet access.
  final Dio _dio = Dio();

  /// Checks current connectivity and verifies internet availability.
  Future<void> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
    (await (connectivity.checkConnectivity()));
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
      } else {
        isInternet = await _internetAvailable();
      }
      connectivitySubscription =
          connectivity.onConnectivityChanged.listen(_internetStream);
    } catch (e) {
      CustomLog.error(this, "HasInternetConnection :", e);
    }
  }

  /// Listener method triggered when connectivity status changes.
  Future<void> _internetStream(List<ConnectivityResult> result) async {
    connectionStatus = result;
    checkConnectivity();
  }

  /// Verifies actual internet access by making a test API call.
  Future<bool> _internetAvailable() async {
    try {
      final response = await _dio.get('https://dart.dev');
      return (response.statusCode == 200);
    } catch (e) {
      return false;
    }
  }

}
