import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/data/model/result.dart';
import 'package:flutter_mvvm_bloc_cubit/routing/app_route_name.dart';
import 'package:go_router/go_router.dart';

import 'common_widgets.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: genericErrorWidget(
        error: GenericError(),
        onRefresh: (){
          context.push(AppRouteName.splash);
        }
      ),
    );
  }
}
