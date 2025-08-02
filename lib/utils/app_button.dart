import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_button_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/string_extensions.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final bool? isLoading;
  final bool? isLinearGradient;
  const AppButton({super.key, this.onPressed, this.isLoading = false, required this.title, this.textStyle,  this.style, this.isLinearGradient = true});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        // White Base
        Container(
            height: commonButtonHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(commonButtonRadius),
            ),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLinearGradient != null
                  ? AppColors.buttonGradientColor
                  : style == AppButtonStyle.logout ? [Colors.white] : [AppColors.primaryColor, AppColors.primaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(commonButtonRadius),
          ),
          child: ElevatedButton(
            onPressed: isLoading == true ? (){} : (){
              commonHapticFeedback();
              onPressed?.call();
            },
            style: isLoading == true ? AppButtonStyle.disableButton :  (style ?? AppButtonStyle.primary),
            child: isLoading == true
                ? const CupertinoActivityIndicator()
                : Text(title.capitalize,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle ?? (style == AppButtonStyle.secondary ? AppTextStyle.buttonWhiteTextColor.copyWith(inherit: true) : AppTextStyle.button.copyWith(inherit: true)),
            ),
          ),
        ),


      ],
    );
  }
}
