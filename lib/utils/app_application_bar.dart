import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_icons.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/string_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final double? elevation;
  final double? scrolledUnderElevation;
  final List<Widget>? actions;
  final dynamic title;
  final Color? titleColor;
  final Widget? leading;
  final bool? isLeading;
  final bool isCrossLeadingIcon;
  final Color? leadingColor;
  final ButtonStyle? leadingStyle;
  final double? toolbarHeight;
  final void Function()? onLeadingTap;
  final PreferredSizeWidget? bottom;
  const CommonAppBar({
    super.key,
    this.isLeading,
    this.backgroundColor,
    this.elevation,
    this.actions,
    this.title,
    this.titleColor,
    this.leading,
    this.leadingColor,
    this.onLeadingTap,
    this.bottom,
    this.toolbarHeight,
    this.leadingStyle,
    this.scrolledUnderElevation,
    this.isCrossLeadingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget? getWidget() {
      if (title is String) {
        if (title != null) {
          return Text(title.toString().capitalize, style: AppTextStyle.appBar.copyWith(color: titleColor ?? Colors.black));
        } else {
          return null;
        }
      } else if (title is Widget) {
        return title;
      } else {
        return null;
      }
    }

    return AppBar(
      elevation: elevation ?? 0.0,
      scrolledUnderElevation: scrolledUnderElevation ?? 3.0,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: backgroundColor ?? AppColors.appBarBackgroundColor,
      automaticallyImplyLeading: isLeading ?? false,
      leading:
          leading ??
          (isLeading == true || isLeading == null
              ? IconButton(
                  onPressed: onLeadingTap ?? () => Navigator.of(context).pop(),
                  icon: SvgPicture.asset(
                    (isCrossLeadingIcon ? AppIcons.svg.clearOutline : AppIcons.svg.goBack),
                    colorFilter: AppColors.svg(leadingColor ?? Colors.black),
                  ),
                  style: leadingStyle,
                )
              : null),
      centerTitle: true,
      title: getWidget(),
      actions: actions,
      bottom: bottom,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0.0));
}
