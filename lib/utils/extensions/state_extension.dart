import 'package:flutter/widgets.dart';

extension PostFrameCallback on State {

  void frameCallback(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }

}