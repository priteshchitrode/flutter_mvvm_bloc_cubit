import 'dart:async';

import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle withColor(Color color) => this.copyWith(color: color);
}

extension ClickListener on Widget {
  Widget onClick(Function()? clickHandler) {
    /// Log button click
    // FirebaseAnalyticsEvents.logButtonClicked(name);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: clickHandler,
      onTap: debounce(clickHandler),
      child: this,
    );
  }
}

/// Debounces a function call so that it is executed only after a certain
/// delay has passed since the last invocation. This can be used to prevent
/// rapid or repeated function calls, such as when handling user input.
///
/// The [func] parameter is the function to be debounced.
///
/// The [delay] parameter is the amount of time to wait after the last
/// invocation of [func] before actually calling it. The default value is
/// 250 milliseconds.
///
/// The function returned by this method can be called in place of [func],
/// and will delay the execution of [func] until the specified delay has
/// elapsed since the last invocation.
debounce(Function? func, [int delay = 250]) {
  Timer? timer;
  return () {
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: delay), () {
      if (func != null) {
        func();
      }
    });
  };
}
