import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/global_variables.dart';


class AppButtonStyle {
  AppButtonStyle._();

  // Primary
  static ButtonStyle primary = ElevatedButton.styleFrom(
    enableFeedback: true,
    elevation: 3.0,
    splashFactory: NoSplash.splashFactory,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.white,
    textStyle: AppTextStyle.button,
    fixedSize: Size(MediaQuery.of(appContext).size.width, commonButtonHeight),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(commonButtonRadius)),
  );

  // Disable
  static ButtonStyle disableButton = primary.copyWith(
    backgroundColor: WidgetStateProperty.all(AppColors.deActiveButtonColor),
    elevation: WidgetStateProperty.all(0),
  );

  // Edit
  static ButtonStyle editButton = primary.copyWith(
      elevation: WidgetStateProperty.all(0),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      fixedSize: WidgetStateProperty.all(const Size(80, 25)));

  // Secondary
  static ButtonStyle secondary = ElevatedButton.styleFrom(
      enableFeedback: true,
      splashFactory: NoSplash.splashFactory,
      surfaceTintColor: Colors.white,
      textStyle: AppTextStyle.buttonWhiteTextColor,
      elevation: 0.0,
      backgroundColor: AppColors.secondaryColor,
      fixedSize: Size(MediaQuery.of(appContext).size.width, commonButtonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(commonButtonRadius)),
  );

  // Outline
  static ButtonStyle outline = OutlinedButton.styleFrom(
      enableFeedback: true,
      splashFactory: NoSplash.splashFactory,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0.0,
      fixedSize: Size(MediaQuery.of(appContext).size.width, commonButtonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(commonButtonRadius)),
      side: const BorderSide(color: AppColors.secondaryColor, width: 1.5),
  );

  // Logout
  static ButtonStyle logout = ElevatedButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.white,
    side: const BorderSide(color: Colors.red, width: 1),
    fixedSize: Size(MediaQuery.of(appContext).size.width, commonButtonHeight),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(commonButtonRadius)),

  );

  // Icon Button
  static ButtonStyle primaryIconButtonStyle = IconButton.styleFrom(
    enableFeedback: true,
    surfaceTintColor: AppColors.lightGreyColor,
    splashFactory: NoSplash.splashFactory,
    backgroundColor: AppColors.lightGreyIconBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  );


  static ButtonStyle primaryIconButtonStyleWithWhiteBackground = IconButton.styleFrom(
    enableFeedback: true,
    surfaceTintColor: AppColors.lightGreyColor,
    splashFactory: NoSplash.splashFactory,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  );

  // Active Icon Button
  static ButtonStyle activeIconButtonStyle = IconButton.styleFrom(
    enableFeedback: true,
    surfaceTintColor: AppColors.lightGreyColor,
    splashFactory: NoSplash.splashFactory,
    backgroundColor: AppColors.lightPrimaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    side: const BorderSide(color: AppColors.primaryColor, width: 1),
  );


  // Text Button Style
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    enableFeedback: true,
    splashFactory: NoSplash.splashFactory,
    surfaceTintColor: Colors.white,
    backgroundColor: AppColors.secondaryColor,
    textStyle: AppTextStyle.h6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  );

  static ButtonStyle textButtonStyle2 = TextButton.styleFrom(
    enableFeedback: true,
    splashFactory: NoSplash.splashFactory,
    surfaceTintColor: Colors.white,
    backgroundColor: AppColors.secondaryButtonColor,
    fixedSize: const Size(160, commonTextButtonHeight),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(commonButtonRadius)),
  );

}
