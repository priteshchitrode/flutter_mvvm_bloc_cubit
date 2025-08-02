import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_bloc_cubit/helpers/date_helper.dart';
import 'package:logger/logger.dart';

class CustomLog {

  static final _logger = Logger(printer: PrettyPrinter());

  static void debug(Object instance, String message) {
    if(kDebugMode){
      _logger.d(message = "[${instance.runtimeType.toString()}] $message", time: DateTimeHelper.now());
    }
  }

  static void info(Object instance, String message) {
    if(kDebugMode){
      _logger.i(message = "[${instance.runtimeType.toString()}] $message", time: DateTimeHelper.now());
    }
  }

  static void error(Object instance, String message, Object? exception) {
    if(kDebugMode){
      _logger.e(message = "[${instance.runtimeType.toString()}] $message}",
          time: DateTime.now(),
          error: exception);
    }
  }

}