import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_button.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_button_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_image.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/string_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

/// Input Decoration
InputDecoration commonInputDecoration({
  String? hintText,
  Color? suffixIconColor,
  dynamic suffixIcon,
  Function()? suffixOnTap,
  Widget? dateTime,
  Widget? prefixIcon,
  Color? fillColor,
  Color? focusColor,
  bool? enableBorder = true,
  TextStyle? hintStyle,
}) {
  Widget? getIconWidget() {
    if (suffixIcon is String) {
      if (suffixIcon.toString().contains(".svg")) {
        return InkWell(
          onTap: suffixOnTap ?? () {},
          child: SvgPicture.asset(suffixIcon, colorFilter: AppColors.svg(suffixIconColor ?? AppColors.greyIconColor)).paddingAll(15),
        );
      } else {
        return InkWell(
          onTap: suffixOnTap ?? () {},
          child: Image.asset(suffixIcon, color: suffixIconColor ?? AppColors.greyIconColor).paddingAll(15),
        );
      }
    } else if (suffixIcon is IconData) {
      return InkWell(onTap: suffixOnTap ?? () {}, child: Icon(suffixIcon).paddingAll(15));
    } else if (suffixIcon is Widget) {
      return InkWell(onTap: suffixOnTap ?? () {}, child: suffixIcon.paddingAll(15));
    } else {
      return null;
    }
  }

  double borderRadius = commonTexFieldRadius;

  return InputDecoration(
    alignLabelWithHint: true,
    contentPadding: const EdgeInsets.all(14),
    filled: true,
    prefixIcon: prefixIcon,
    hintText: hintText.capitalizeFirst,
    hintStyle: hintStyle ?? AppTextStyle.textFieldHint,
    fillColor: fillColor ?? AppColors.textFieldFillColor,
    counterText: '',
    suffixIcon: getIconWidget(),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focusColor ?? AppColors.secondaryColor, width: 1),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: enableBorder == false ? Colors.transparent : Colors.red),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: enableBorder == false ? Colors.transparent : Colors.red),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );
}

/// Lottie Animation widget
Widget lottieAnimation({required String file, bool? repeat, double? width}) {
  return Lottie.asset(file, width: width, fit: BoxFit.cover, frameRate: const FrameRate(60), repeat: repeat ?? true);
}

/// Common cache network image widget
Widget commonCacheNetworkImage({required String path, dynamic errorImage, double? height, double? width, BoxFit? fit, double? radius}) {
  Widget? getIconWidget() {
    if (errorImage is String) {
      if (errorImage.toString().contains(".svg")) {
        return SvgPicture.asset(errorImage);
      } else {
        return Image.asset(errorImage);
      }
    } else if (errorImage is IconData) {
      return Icon(errorImage);
    } else if (errorImage is Widget) {
      return errorImage;
    } else {
      return null;
    }
  }

  Widget errorWidget() {
    return Container(
      color: errorImage == null ? AppColors.lightGreyColor : Colors.transparent,
      height: height,
      width: width,
      alignment: Alignment.center,
      child: errorImage == null
          ? Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(commonSafeAreaPadding),
              decoration: commonContainerDecoration(color: AppColors.lightGreyIconBackgroundColor, borderRadius: BorderRadius.circular(radius ?? 0)),
              child: Image.asset(AppImage.png.brokenImage, width: 40),
            )
          : getIconWidget(),
    ).cornerRadiusWithClipRRect(radius ?? 5);
  }

  if (path.isNotEmpty) {
    if (Uri.tryParse(path)?.hasAbsolutePath ?? false) {
      return CachedNetworkImage(
        imageUrl: path.trim(), // Trim whitespace
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
        placeholder: (context, url) => Center(
          child: Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white10,
            child: Container(color: Colors.white, height: height, width: width),
          ).cornerRadiusWithClipRRect(radius ?? 5),
        ),
        errorWidget: (context, url, error) {
          return errorWidget();
        },
      ).cornerRadiusWithClipRRect(radius ?? 5);
    } else {
      debugPrint("Invalid Image URL: $path");
    }
  }
  return errorWidget();
}

/// Container decoration
BoxDecoration commonContainerDecoration({
  bool? shadow,
  Color? color,
  Color? shadowColor,
  BorderRadiusGeometry? borderRadius,
  Color? borderColor,
  double? borderWidth,
  double? blurRadius,
  Gradient? gradient,
}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    gradient: gradient,
    borderRadius: borderRadius ?? BorderRadius.circular(commonRadius),
    border: Border.all(color: borderColor ?? Colors.transparent, width: borderWidth ?? 1.0),
    boxShadow: shadow == true ? [BoxShadow(color: shadowColor ?? AppColors.shadowColor, blurRadius: blurRadius ?? 5.0)] : [],
  );
}

/// Generic error widget
Widget genericErrorWidget({ErrorType? error, void Function()? onRefresh, void Function()? goBack}) {
  log("Error Type : ${getErrorMsg(errorType: error ?? GenericError())}");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // SvgPicture.asset(getErrorImage(errorType: error!), width: 200),
      SvgPicture.asset(AppImage.svg.noSearchFound, width: 200),
      50.height,
      Text(
        getErrorMsg(errorType: error ?? GenericError()),
        textAlign: TextAlign.center,
        style: AppTextStyle.body2,
      ),
      50.height,
      if (onRefresh != null) AppButton(title: AppString.label.refresh, onPressed: onRefresh, style: AppButtonStyle.secondary),
      20.height,
      if (goBack != null) AppButton(title: AppString.label.back, onPressed: goBack),
    ],
  ).center().isAnimate().paddingAll(commonSafeAreaPadding);
}

/// Common Detail Widget
Widget commonDetailWidget({required String title, required String subTitle, bool? isVertical, TextStyle? subTitleTextStyle}) {
  if (isVertical == null || isVertical == false) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: AppTextStyle.body.copyWith(color: AppColors.titleTextColor),
        ),
        10.width,
        Text(
          subTitle,
          textAlign: TextAlign.end,
          style: subTitleTextStyle ?? AppTextStyle.body.copyWith(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
        ).expand(),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: AppTextStyle.body.copyWith(color: AppColors.titleTextColor),
        ),
        5.height,
        Text(
          subTitle,
          textAlign: TextAlign.start,
          style: subTitleTextStyle ?? AppTextStyle.body.copyWith(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

/// Common List Tile widget
Widget commonListTile({
  required String title,
  TextStyle? titleStyle,
  String? subTitle,
  Color? titleColor,
  Color? iconBgColor,
  Color? iconColor,
  String? iconSvg,
  void Function()? onTap,
  Widget? trailing,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: iconSvg != null
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: commonContainerDecoration(color: iconBgColor ?? Colors.transparent, borderRadius: BorderRadius.circular(100)),
            child: SvgPicture.asset(iconSvg, color: iconColor),
          )
        : null,
    title: Text(title),
    titleTextStyle: titleStyle ?? AppTextStyle.body2.copyWith(fontWeight: FontWeight.w500, color: titleColor ?? AppColors.primaryTextColor),
    subtitle: subTitle != null ? Text(subTitle) : null,
    subtitleTextStyle: const TextStyle(color: AppColors.greyTextColor),
    trailing: trailing ?? const Icon(Icons.keyboard_arrow_right_rounded, color: AppColors.greyIconColor),
    onTap: onTap ?? () {},
  );
}

/// Common divider widget
Widget commonDivider({double? height, Color? dividerColor, double? indent, double? endIndent}) {
  return Divider(
      color: dividerColor ?? AppColors.lightDividerColor,
      height: height ?? 30,
      indent: indent,
      endIndent: endIndent,
  );
}

/// Doc Grid UI widget
Widget docsGridDesign(String docType) {
  return Material(
    elevation: 0.0,
    color: AppColors.extraLightBackgroundGray,
    child: Container(
      height: 160,
      width: double.infinity,
      alignment: Alignment.center,
      child: Image.asset("assets/images/png/$docType.png", width: 50).paddingBottom(25),
    ),
  );
}

Widget iconsGridDesign(icon) {
  return Icon(icon, color: icon == CupertinoIcons.photo_on_rectangle ? AppColors.greyIconColor : AppColors.greyIconColor, size: 20);
}

/// App Loader widget
Widget appLoader() {
  return const CircularProgressIndicator(strokeCap: StrokeCap.round).paddingBottom(60).center();
}

/// Navigate to Token fail screen
// Widget navigateToTokenExpireScreen(BuildContext context){
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     Navigator.of(context).pushNamedAndRemoveUntil(RouteName.tokenExpire, (route) => false);
//   });
//   return Container();
// }
