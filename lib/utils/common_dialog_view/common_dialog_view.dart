import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_button.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_button_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_icon_button.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/state_extension.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/string_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';

class CommonDialogView extends StatefulWidget {
  final String? message;
  final String? heading;
  final Color? headingColor;
  final bool? showYesNoButtonButtons;
  final bool? hideCloseButton;
  final bool? yesButtonLoading;
  final String? yesButtonText;
  final String? noButtonText;
  final String? onSingleButtonText;
  final TextStyle? headingTextStyle;
  final TextStyle? messageTextStyle;
  final ButtonStyle? yesButtonTextStyle;
  final Widget? child;
  final void Function()? onTapSingleButton;
  final void Function()? afterDismiss;
  final GestureTapCallback? onClickYesButton;
  final GestureTapCallback? onClickNoButton;
  final CrossAxisAlignment? crossAxisAlignment;
  const CommonDialogView({
    super.key,
    this.child,
    this.onClickYesButton,
    this.onClickNoButton,
    this.showYesNoButtonButtons = false,
    this.yesButtonText,
    this.noButtonText,
    this.message,
    this.heading,
    this.onTapSingleButton,
    this.afterDismiss,
    this.onSingleButtonText,
    this.headingColor,
    this.hideCloseButton = false,
    this.yesButtonLoading = false,
    this.crossAxisAlignment,
    this.headingTextStyle,
    this.messageTextStyle,
    this.yesButtonTextStyle,
  });

  @override
  State<CommonDialogView> createState() => _CommonDialogViewState();
}

class _CommonDialogViewState extends State<CommonDialogView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    disposeFunction();
    super.dispose();
  }

  void disposeFunction() => frameCallback(() async {
    if (widget.afterDismiss != null) {
      widget.afterDismiss!.call();
    }
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        if (!widget.hideCloseButton!) ...[
          AppIconButton(onPressed: () => Navigator.of(context).pop(), icon: Icons.close).align(Alignment.topRight),
          10.height,
        ] else ...[
          10.height,
        ],

        if (widget.child != null) ...[widget.child!, 20.height],

        if (widget.heading != null) ...[
          Text(
            widget.heading!.capitalize,
            textAlign: TextAlign.center,
            style: widget.headingTextStyle ?? AppTextStyle.h3.copyWith(color: widget.headingColor ?? Colors.black, fontSize: 25),
          ),
          10.height,
        ],

        if (widget.message != null) ...[
          Text(widget.message!, textAlign: TextAlign.center, style: widget.messageTextStyle ?? AppTextStyle.bodyGreyColor),
          20.height,
        ],

        if (widget.onTapSingleButton != null) ...[
          AppButton(onPressed: widget.onTapSingleButton ?? () {}, title: widget.onSingleButtonText ?? "Continue"),
        ],

        // Buttons
        if (widget.showYesNoButtonButtons!)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // No Button
              AppButton(
                style: AppButtonStyle.outline,
                title: widget.noButtonText ?? "No",
                onPressed:
                    widget.onClickNoButton ??
                    () {
                      Navigator.pop(context);
                    },
              ).expand(),
              16.width,

              // Yes Button
              AppButton(
                style: widget.yesButtonTextStyle ?? AppButtonStyle.primary,
                isLoading: widget.yesButtonLoading,
                onPressed: widget.onClickYesButton ?? () {},
                title: widget.yesButtonText ?? "Yes",
              ).expand(),
            ],
          ),
      ],
    ).paddingOnly(bottom: 5, left: 5, right: 5);
  }
}
