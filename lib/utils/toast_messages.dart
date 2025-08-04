import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/global_variables.dart';
import 'app_colors.dart';
import 'app_global_variables.dart';
import 'app_text_style.dart';

class ToastMessages{
  ToastMessages._();

  // Error Msg
  static internetError({required String message}) async {
    Flushbar(
      messageText: Text(message, style: AppTextStyle.body),
      messageColor:  Colors.white,
      flushbarPosition: FlushbarPosition.TOP ,
      backgroundColor:   AppColors.scaffoldBackgroundColor,
      isDismissible: false,
      boxShadows: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius:  10.0, // soften the shadow
          spreadRadius:  3.0, //extend the shadow
        )
      ],
      icon: const Icon(Icons.wifi_off_rounded, size : 25,  color: AppColors.secondaryColor).paddingAll(10).paddingLeft(10),
      duration: const Duration(milliseconds: 3000),
    ).show(navigatorKey.currentState!.context);
  }

  // success Msg
  static success({required String message}) async {
    Flushbar(
      messageText: Text(message,  style: AppTextStyle.body),
      flushbarPosition: FlushbarPosition.TOP ,
      backgroundColor:   AppColors.scaffoldBackgroundColor,
      isDismissible: false,
      boxShadows: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius:  10.0, // soften the shadow
          spreadRadius:  3.0, //extend the shadow
        )
      ],
      icon: const Icon(Icons.check_circle_rounded, size : 25, color: Colors.green).paddingAll(10).paddingLeft(5),
      duration: const Duration(milliseconds: 3000),
    ).show(navigatorKey.currentState!.context);
  }

  // Error Msg
  static error({required String message}) {
    Flushbar(
      messageText: Text(message, style: AppTextStyle.body),
      flushbarPosition: FlushbarPosition.TOP ,
      backgroundColor:  AppColors.scaffoldBackgroundColor,
      isDismissible: false,
      boxShadows: const [
        BoxShadow(
          color:  Colors.black26,
          blurRadius:  10.0, // soften the shadow
          spreadRadius: 3.0, //extend the shadow
        )
      ],
      icon: const Icon(Icons.error, size : 25, color:  Colors.red).paddingAll(10).paddingLeft(5),
      duration: const Duration(milliseconds: 3500),
    ).show(appContext);
  }

  // Error Msg
  static alert({required String message}) {
    Flushbar(
      messageText: Text(message, style: AppTextStyle.body),
      flushbarPosition: FlushbarPosition.TOP ,
      backgroundColor:  AppColors.scaffoldBackgroundColor,
      isDismissible: false,
      boxShadows: const [
        BoxShadow(
          color:  Colors.black26,
          blurRadius:  10.0, // soften the shadow
          spreadRadius: 3.0, //extend the shadow
        )
      ],
      icon: const Icon(Icons.error, size : 25, color:  Colors.orange).paddingAll(10).paddingLeft(5),
      duration: const Duration(milliseconds: 3500),
    ).show(navigatorKey.currentState!.context);
  }

  // Custom toast
  static custom({required String message}) {
    Flushbar(
      messageText: Text(message, style: AppTextStyle.body),
      flushbarPosition: FlushbarPosition.TOP ,
      backgroundColor:  AppColors.scaffoldBackgroundColor,
      isDismissible: false,
      boxShadows: const [
        BoxShadow(
          color:  Colors.black26,
          blurRadius:  10.0, // soften the shadow
          spreadRadius: 3.0, //extend the shadow
        )
      ],
      icon: const Icon(Icons.warning_rounded, size : 25, color:  AppColors.secondaryColor).paddingAll(10).paddingLeft(5),
      duration: const Duration(milliseconds: 3000),
    ).show(navigatorKey.currentState!.context);
  }


}