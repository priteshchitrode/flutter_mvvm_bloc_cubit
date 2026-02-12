import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_icons.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/upload_images_and_documents/image_picker_from.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/upload_images_and_documents/pick_multiple_files.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/upload_images_and_documents/picked_images_and_documents_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadFileAndImageBottomSheet extends StatefulWidget {
  const UploadFileAndImageBottomSheet({super.key});

  @override
  State<UploadFileAndImageBottomSheet> createState() => _UploadFileAndImageBottomSheetState();
}

class _UploadFileAndImageBottomSheetState extends State<UploadFileAndImageBottomSheet> {
  var exitIcons = [AppIcons.svg.camera, AppIcons.svg.gallery];
  var exitNames = [AppString.label.fromCamera, AppString.label.fromGallery];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          10.height,

          // Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppString.label.selectImageFrom, style: AppTextStyle.appBar),
              IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.clear_rounded)),
            ],
          ),
          20.height,

          // Option
          Column(
            children: [
              for (var i = 0; i < exitIcons.length; i++) ...[
                InkWell(
                  onTap: () async {
                    if (!context.mounted) return;
                    dynamic result;
                    switch (i) {
                      case 0:
                        result = await ImagePickerFrom.fromCamera();
                        break;
                      case 1:
                        result = await ImagePickerFrom.fromGallery();
                        break;
                      default:
                        result = await pickMultipleFile(context: context, type: "add");
                    }

                    if (!context.mounted) return;
                    final isValid = (result is PickedImageModel || (result is List<PickedImageModel> && result.isNotEmpty));
                    if (isValid) {
                      Navigator.of(context).pop(result);
                    }
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        10.width,
                        SvgPicture.asset(exitIcons[i], colorFilter: AppColors.svg(AppColors.greyIconColor)),
                        20.width,
                        Text(exitNames[i].toString(), style: AppTextStyle.body2),
                      ],
                    ),
                  ),
                ),
                if (i != exitIcons.length - 1) const Divider(color: AppColors.dividerColor, indent: 55, thickness: 0.5),
              ],
            ],
          ),
          50.height,
        ],
      ).paddingSymmetric(horizontal: commonSafeAreaPadding),
    );
  }
}
