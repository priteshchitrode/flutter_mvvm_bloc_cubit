import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_widgets.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';

class AppBottomSheetBody extends StatefulWidget {
  final String? title;
  final bool? isCloseButton;
  final Widget body;

  const AppBottomSheetBody({super.key, this.title, this.isCloseButton = true, required this.body});

  @override
  State<AppBottomSheetBody> createState() => _AppBottomSheetBodyState();
}

class _AppBottomSheetBodyState extends State<AppBottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            15.height,
            // AppBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.title != null) Text(widget.title ?? "", style: AppTextStyle.appBar) else 0.width,

                if (widget.isCloseButton != null && widget.isCloseButton!)
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.clear_rounded)),
              ],
            ).paddingSymmetric(horizontal: commonSafeAreaPadding),

            commonDivider(height: 15, dividerColor: AppColors.lightDividerColor),
            20.height,

            // body
            widget.body.paddingSymmetric(horizontal: commonSafeAreaPadding),
            50.height,
          ],
        ),
      ),
    );
  }
}
