import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_widgets.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/string_extensions.dart';

class AppDropdown extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final String? dropdownValue;
  final List<DropdownMenuItem<String>> dropDownList;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? onSaved;
  const AppDropdown({super.key, this.labelText, this.hintText, this.currentFocus, this.nextFocus, this.decoration, this.prefixIcon, required this.dropdownValue, required this.dropDownList, this.validator, this.onChanged, this.onSaved, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) Text(" ${labelText.capitalizeFirst}", style: AppTextStyle.body3),
        if (labelText != null) 6.height,
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            dropdownColor: AppColors.scaffoldBackgroundColor,
            isExpanded: false,
            enableFeedback: true,
            decoration: decoration ?? commonInputDecoration(),
            focusNode: currentFocus,
            borderRadius: BorderRadius.circular(commonRadius),
            value: dropdownValue,
            style: AppTextStyle.textFiled,
            hint: hintText != null ? Text(hintText.capitalizeFirst, style: AppTextStyle.textFieldHint) : null,
            items: dropDownList,
            onChanged: onChanged!,
            onTap: onTap,
            onSaved: onSaved,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
