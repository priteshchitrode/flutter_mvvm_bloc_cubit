import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/core/base_state.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';
import 'package:lottie/lottie.dart';
import 'app_button.dart';
import 'app_colors.dart';
import 'app_json.dart';
import 'app_string.dart';
import 'app_text_style.dart';
import 'constant_variables.dart';

class GenericSuccessScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool residentHome;
  final bool securityHome;
  final bool goBack;
  const GenericSuccessScreen({super.key, required this.title, required this.subtitle,  this.residentHome = false, this.securityHome = false, this.goBack = false});

  @override
  BaseState<GenericSuccessScreen> createState() => _GenericSuccessScreenState();
}

class _GenericSuccessScreenState extends BaseState<GenericSuccessScreen> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(commonSafeAreaPadding),
        child: Stack(
          alignment: Alignment.center,
          children: [

            Lottie.asset(AppJSON.accountCreateSuccessfully, repeat: false, frameRate: const FrameRate(60)).paddingBottom(50),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title, textAlign: TextAlign.center, style: AppTextStyle.h2.copyWith(color: AppColors.secondaryColor)),
                250.height,
                Text(widget.subtitle,  textAlign: TextAlign.center, style: AppTextStyle.body2).paddingSymmetric(horizontal: 10),
                30.height,
                AppButton(
                  onPressed: (){

                  },
                  title: AppString.label.backToHome,
                ),
              ],
            ).isAnimate().center(),
          ],
        ),

      ),
    );
  }
}
