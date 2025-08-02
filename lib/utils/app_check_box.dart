import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';


class AppCheckBox extends StatelessWidget {
  final void Function(bool?)? onChanged;
  final bool? value;
  final String? title;
  const AppCheckBox({super.key, required this.onChanged, required this.value , this.title,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (value != null) {
          onChanged?.call(!value!);
        }
      },
      child: Row(
        mainAxisSize: title == null ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            activeColor: AppColors.secondaryColor,
            checkColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onChanged: onChanged,
          ),

          if(title != null)
            Text(title!, style: AppTextStyle.body2),
        ],
      ),
    );
  }
}
