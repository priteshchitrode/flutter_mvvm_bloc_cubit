import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemeStyle {
  AppThemeStyle._();

  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.scaffoldBackgroundColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        surfaceTint: Colors.transparent,
        brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    useMaterial3: true,
    appBarTheme:  const AppBarTheme(
        shadowColor: AppColors.shadowColor,
        backgroundColor: AppColors.appBarBackgroundColor,
        surfaceTintColor: Colors.white,
    ),
  );

  static TimePickerThemeData timePickerTheme = TimePickerThemeData(
    hourMinuteColor: AppColors.secondaryColor, // Hour & Minute background
    hourMinuteTextColor: Colors.white, // Hour & Minute text color
    dialHandColor: AppColors.secondaryColor, // Dial hand color
    dialBackgroundColor: Colors.white, // Dial background color
    dayPeriodColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected)
        ? AppColors.secondaryColor // Selected AM/PM Background
        : Colors.white), // Unselected AM/PM Background
    dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected)
        ? Colors.white // Selected AM/PM Text Color
        : Colors.black), // Unselected AM/PM Text Color
  );


}