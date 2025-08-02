import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_global_variables.dart';
import 'common_functions.dart';
import 'constant_variables.dart';


/// Route
Route createRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.5);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route commonRoute(Widget screen, {bool isForward = false, bool nativeMode = false}){
  if(isAndroid){
    if(isForward){
      return CupertinoPageRoute(builder: (context) => screen);
    }
    if(nativeMode){
      return MaterialPageRoute(builder: (context) => screen);
    }
    return createRoute(screen);
  }else{
    if(isForward){
      return CupertinoPageRoute(builder: (context) => screen);
    }
    return createRoute(screen);
  }
}



Route splashRoute(Widget screen){
  return MaterialPageRoute(builder: (context) => screen);
}

/// Bottom Sheet
Future<dynamic> commonBottomSheet<T>({required BuildContext context, required Widget screen, bool? barrierDismissible}) async {
  commonHideKeyboard(context);
  commonHapticFeedback();
  return  showCupertinoModalPopup<void>(
    barrierColor: Colors.black12,
    barrierDismissible: barrierDismissible ?? false,
    context: context,
    builder: (context) =>  ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(commonBottomSheetRadius), topRight: Radius.circular(commonBottomSheetRadius)),
        child: screen),
  );
  //return null;
}

Route createHeroAnimationRoute(Widget screen) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      final curvedAnimation = CurvedAnimation(parent: animation, curve: const Interval(0, 0.5));
      return FadeTransition(
        opacity: curvedAnimation,
        child: screen,
      );
    },
  );
}

Future<dynamic> commonBottomSheetWithBGBlur<T>({required BuildContext context, required Widget screen, double? radius}) async {
  commonHideKeyboard(context);
  return showCupertinoModalPopup<void>(
    barrierColor: Colors.black12,
    barrierDismissible: false,
    context: context,
    builder: (context) =>  BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 5,
        sigmaX: 5,
      ),
      child: ClipRRect(
          borderRadius:  BorderRadius.only(topLeft: Radius.circular(radius ?? commonBottomSheetRadius), topRight: Radius.circular(radius ?? commonBottomSheetRadius)),
          child: screen,
      ),
    ),
  );
}

