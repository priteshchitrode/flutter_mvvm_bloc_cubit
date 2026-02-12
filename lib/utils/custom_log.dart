import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_bloc_cubit/helpers/date_helper.dart';
import 'package:logger/logger.dart';

class CustomLog {
  static final Logger _logger = Logger(printer: PrettyPrinter());

  static void debug(Object instance, String message) {
    if (kDebugMode) {
      final formattedMessage = "[${instance.runtimeType}] $message";
      _logger.d(formattedMessage, time: DateTimeHelper.now());
    }
  }

  static void info(Object instance, String message) {
    if (kDebugMode) {
      final formattedMessage = "[${instance.runtimeType}] $message";
      _logger.i(formattedMessage, time: DateTimeHelper.now());
    }
  }

  static void error(Object instance, String message, [Object? exception, StackTrace? stackTrace]) {
    if (kDebugMode) {
      final formattedMessage = "[${instance.runtimeType}] $message";
      _logger.e(formattedMessage, time: DateTimeHelper.now(), error: exception, stackTrace: stackTrace);
    }
  }
}
