import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_icons.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoSearchResultFoundWidget extends StatelessWidget {
  final String value;
  const NoSearchResultFoundWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.svg.search, width: 40, colorFilter: AppColors.svg(AppColors.greyIconColor)),
          20.height,
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text('${AppString.label.noResultFor} ', style: AppTextStyle.h4w500),
              Text(value, style: AppTextStyle.h4w500.copyWith(color: AppColors.blueColor)),
            ],
          ),
          10.height,
          Text(AppString.label.checkSpellingSearch, style: AppTextStyle.body3GreyColor, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
