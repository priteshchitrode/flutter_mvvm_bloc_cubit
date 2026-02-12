import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/dependency_injection/locator.dart';
import 'package:flutter_mvvm_bloc_cubit/helpers/analytics_helper.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/custom_log.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  final AnalyticsHelper analyticsHelper = locator<AnalyticsHelper>();

  @override
  void initState() {
    super.initState();
    logScreenView();
  }

  void logScreenView() {
    analyticsHelper.logScreenView(widget.toString(), T.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    CustomLog.info(this, "Disposed Called");
    super.dispose();
  }
}
