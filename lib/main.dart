import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/core/app_initializer.dart';
import 'package:flutter_mvvm_bloc_cubit/multi_bloc.dart';
import 'package:flutter_mvvm_bloc_cubit/routing/app_routes.dart';
import 'package:flutter_mvvm_bloc_cubit/service/has_internet_connection.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_theme_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/state_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initFun();
    super.initState();
  }

  void initFun() => frameCallback(() async {
    await HasInternetConnection().checkConnectivity();
    // await authRepo.signOut();
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocWrapper(
      child: MaterialApp.router(
        title: "Update Your App Name",
        debugShowCheckedModeBanner: true,
        theme: AppThemeStyle.appTheme,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
