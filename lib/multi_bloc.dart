import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_bloc_cubit/dependency_injection/locator.dart';
import 'package:flutter_mvvm_bloc_cubit/features/authentication/cubit/login/login_cubit.dart';


class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => locator<LoginCubit>()),
      ],
      child: child,
    );
  }
}
