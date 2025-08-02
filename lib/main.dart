import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/state_extension.dart';
import 'core/app_initializer.dart';
import 'multi_bloc.dart';
import 'routing/app_routes.dart';
import 'service/hasInternet/has_internet_connection.dart';
import 'utils/app_theme_style.dart';

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

  initFun() => frameCallback(() async {
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
