import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/dependency_injection/locator.dart';
import 'package:flutter_mvvm_bloc_cubit/enum/status.dart';
import 'package:flutter_mvvm_bloc_cubit/routing/app_route_name.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/state_extension.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/toast_messages.dart';
import 'package:go_router/go_router.dart';
import 'splash_view_mode.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashViewModel = locator<SplashViewModel>();

  @override
  void initState() {
    init(context);
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  //  Init Function
  Future<void> init(BuildContext context) async {

    await Future.delayed(const Duration(seconds: 5), () async {

      /// For dummy purpose it will redirect in home page after 4 sec.
      if (!context.mounted) return;
      context.go(AppRouteName.home);

      ///  Use this when you have complete login & sign-up flow
      //  await splashViewModel.fetchIsUserLogin();
    });


    /// Use this when you have complete login & sign-up flow
    // if (splashViewModel.checkIsUserLoginUIState != null && splashViewModel.checkIsUserLoginUIState?.status != null) {
    //   if (splashViewModel.checkIsUserLoginUIState?.status == Status.SUCCESS) {
    //     if (splashViewModel.checkIsUserLoginUIState!.data == true) {
    //       if (!context.mounted) return;
    //       context.go(AppRouteName.home);
    //     }
    //   }
    //   if (splashViewModel.checkIsUserLoginUIState?.status == Status.ERROR) {
    //     if (!context.mounted) return;
    //     frameCallback(()=> context.push(AppRouteName.signIn));
    //   }
    // } else {
    //   ToastMessages.error(message: getErrorMsg(errorType: GenericError()));
    // }


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome To Flutter MVVM", style: AppTextStyle.h3),
            5.height,
            Text("Using Bloc State", style: AppTextStyle.h3),
            5.height,
            Text("With SOLID Principle", style: AppTextStyle.h3),
          ],
        ).center().paddingAll(commonSafeAreaPadding),
      ),
    );
  }
}
