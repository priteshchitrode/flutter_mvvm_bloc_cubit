import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Base Color
  static const Color primaryColor = Color(0xffFECB00);
  static const Color secondaryColor = Color(0xff4D4D4D);

  // Light Base Color
  static const Color lightPrimaryColor = Color(0xffFFFAE5);
  static const Color extraLightPrimaryColor = Color(0xffFFFFCF2);

  // Text Color
  static const Color primaryTextColor = Color(0xff292D32);
  static const Color greyTextColor = Color(0xff64748B);
  static const Color textFieldFillColor = Color(0xffF8FAFC);
  static const Color textFieldFocusedFillColor = Color(0xffF1F1FE);
  static const Color lightGreyTextColor = Color(0xff606060);
  static const Color titleTextColor = Color(0xFF5A6474);
  static const Color extraLightGreyTextColor = Colors.black38;
  static const Color textColor = Color(0xFF512B15);

  // Button Color
  static const Color primaryButtonColor = primaryColor;
  static const Color secondaryButtonColor = Color(0xff222831);
  static const Color deActiveButtonColor = Color(0xffe3e3e8);
  static List<Color> buttonGradientColor = [primaryColor.withAlpha(450), primaryColor, primaryColor];

  // Status Color
  static const Color activeGreenColor = CupertinoColors.activeGreen;
  static const Color activeBlueColor = CupertinoColors.activeBlue;

  // Icon Color
  static const Color iconColor = Color(0xff606060);
  static const Color greyIconColor = Colors.black38;
  static const Color lightGreyIconColor = Colors.black26;
  static const Color greyIconBackgroundColor = Color(0xffe3e3e8);
  static final Color lightGreyIconBackgroundColor = Colors.grey.shade200;
  static const Color defaultIconTint = Colors.white;

  // Other Color
  static const Color scaffoldBackgroundColor = Color(0xffFCFCFC);
  static const Color appBarBackgroundColor = Color(0xffFCFCFC);
  static const Color lightGreyColor = Color(0xffF8FAFC);
  static Color extraLightBackgroundGray = CupertinoColors.extraLightBackgroundGray.withOpacity(0.5);
  static const Color darkGreyColor = Color(0xff838383);
  static const Color shadowColor = Color(0xffdfdfdf);
  static const Color borderColor = Color(0xffDBDBDB);
  static const Color dividerColor = CupertinoColors.opaqueSeparator;
  static const Color lightDividerColor = Colors.black12;
  static const Color darkDividerColor = Color(0xff707070);
  static final Color shimmerBaseColor = Colors.grey.shade100;
  static final Color disableColor = Colors.grey.shade50;
  static const Color shimmerHighlightColor = Colors.white10;
  static const Color searchFillColor = Color(0xffF2F2F3);
  static const Color chipBackgroundColor = Color(0xFFF4F0E9);

  static const Color blueColor = Color(0xFF0A4DFF);

  static WidgetStateProperty<Color> materialStateColor(Color color) {
    return WidgetStateProperty.all(color);
  }

  static ColorFilter svg(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }
}
