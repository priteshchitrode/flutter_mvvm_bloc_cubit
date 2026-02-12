import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/dependency_injection/locator.dart';
import 'package:flutter_mvvm_bloc_cubit/enum/status.dart';
import 'package:flutter_mvvm_bloc_cubit/routing/app_route_name.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
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
    await Future.delayed(const Duration(seconds: 4), () async {
      await splashViewModel.fetchIsUserLogin();
    });

    if (splashViewModel.checkIsUserLoginUIState != null && splashViewModel.checkIsUserLoginUIState?.status != null) {
      if (splashViewModel.checkIsUserLoginUIState?.status == Status.SUCCESS) {
        if (splashViewModel.checkIsUserLoginUIState!.data == true) {
          if (!context.mounted) return;
          context.go(AppRouteName.home);
        }
      }
      if (splashViewModel.checkIsUserLoginUIState?.status == Status.ERROR) {
        if (!context.mounted) return;
        frameCallback(() => context.push(AppRouteName.signIn));
      }
    } else {
      ToastMessages.error(message: getErrorMsg(errorType: GenericError()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: const Icon(Icons.accessibility).center()));
  }
}
