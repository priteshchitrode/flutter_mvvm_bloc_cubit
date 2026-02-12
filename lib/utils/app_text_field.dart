import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_widgets.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/string_extensions.dart';


class AppTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Color? inputTextColor;
  final Color? cursorColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign = TextAlign.start;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool? showCursor;
  final bool? autofocus;
  final Function()? onTap;
  final Function()? onTextFieldTap;
  final int? maxLines;
  final bool? obscureText;
  final bool? ignorePointers;
  final int? maxLength;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  const AppTextField(
      {super.key,
      this.controller,
      this.decoration,
      this.onTap,
      this.onTextFieldTap,
      this.labelText,
      this.inputTextColor,
      this.cursorColor,
      this.inputFormatters,
      this.validator,
      this.onFieldSubmitted,
      this.currentFocus,
      this.nextFocus,
      this.keyboardType,
      this.readOnly,
      this.showCursor,
      this.autofocus,
      this.maxLines,
      this.obscureText,
      this.ignorePointers,
      this.maxLength,
      this.textInputAction,
      this.hintText,
      this.onChanged, this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        if (labelText != null) Text(" ${labelText.capitalizeFirst}", style: AppTextStyle.body3),
        if (labelText != null) 6.height,

        // Text Field
        InkWell(
          onTap: onTap ?? () {},
          child: TextFormField(
            validator: validator,
            inputFormatters: inputFormatters ?? [],
            textAlign: textAlign,
            controller: controller,
            focusNode: currentFocus,
            cursorColor: cursorColor ?? AppColors.lightGreyTextColor,
            cursorWidth: 1.5,
            keyboardType: keyboardType,
            maxLines: maxLines ?? 1,
            obscureText: obscureText ?? false,
            obscuringCharacter: "•",
            cursorRadius: const Radius.circular(5),
            readOnly: readOnly ?? false,
            autofocus: autofocus ?? false,
            showCursor: showCursor,
            ignorePointers: ignorePointers,
            style: AppTextStyle.textFiled.copyWith(color:  inputTextColor ?? AppColors.primaryTextColor),
            decoration: decoration ?? commonInputDecoration(hintText: hintText),
            maxLength: maxLength,
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted ??
                (value) {
                  try {
                    fieldFocusChange(context, current: currentFocus!, nextFocus: nextFocus!);
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                },
            onTap: onTextFieldTap ?? () {},
          ),
        ),
      ],
    );
  }
}
