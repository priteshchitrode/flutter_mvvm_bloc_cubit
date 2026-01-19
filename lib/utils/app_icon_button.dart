import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends StatelessWidget {
  final void Function() onPressed;
  final dynamic icon;
  final Color? iconColor;
  final ButtonStyle? style;

  const AppIconButton({super.key, required this.onPressed, required this.icon, this.style, this.iconColor});

  @override
  Widget build(BuildContext context) {
    Widget getIconWidget() {
      if (icon is String) {
        if (icon.toString().contains(".svg")) {
          return SvgPicture.asset(icon, width: 20, colorFilter: iconColor != null ? AppColors.svg(iconColor!) : null);
        } else {
          return Image.asset(icon, width: 20, color: iconColor ?? AppColors.iconColor);
        }
      } else if (icon is IconData) {
        return Icon(icon);
      } else if (icon is Widget) {
        return icon;
      } else {
        return 0.width;
      }
    }

    return IconButton(
      onPressed: () {
        commonHapticFeedback();
        onPressed.call();
      },
      style: style,
      icon: getIconWidget(),
    );
  }
}
