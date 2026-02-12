import 'dart:io';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_icons.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_route.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_widgets.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/upload_images_and_documents/upload_file_and_image_bottom_sheet.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/upload_images_and_documents/picked_images_and_documents_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

@immutable
class UploadAttachmentFiles extends StatefulWidget {
  final List<PickedImageModel> multiFilesList;
  final bool? isSingleImage;
  const UploadAttachmentFiles({super.key, required this.multiFilesList, this.isSingleImage = false});

  @override
  State<UploadAttachmentFiles> createState() => _UploadAttachmentFilesState();
}

class _UploadAttachmentFilesState extends State<UploadAttachmentFiles> {
  bool isFile = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.multiFilesList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(AppString.label.attachment, style: AppTextStyle.textFiled),
              Text(AppString.label.docSupport, style: AppTextStyle.body4GreyColor),
              10.height,

              // Grid View
              MasonryGridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: !widget.isSingleImage! ? (widget.multiFilesList.length + 1) : widget.multiFilesList.length,
                itemBuilder: (ctx, index) {
                  if (widget.multiFilesList.length == index && !widget.isSingleImage!) {
                    if (widget.multiFilesList.length <= 7) {
                      return GestureDetector(
                        onTap: !isFile
                            ? () {
                                commonHideKeyboard(context);
                                commonBottomSheetWithBGBlur(context: context, screen: const UploadFileAndImageBottomSheet()).then((value) {
                                  if (value != null) {
                                    isFile = true;
                                    widget.multiFilesList.add(value);
                                    isFile = false;
                                    debugPrint("Add new : $value");
                                  } else {
                                    isFile = false;
                                  }
                                  if (!context.mounted) return;
                                  commonHideKeyboard(context);
                                });
                                setState(() {});
                              }
                            : () {},
                        child: DottedBorder(
                          options: RectDottedBorderOptions(color: Colors.black12, dashPattern: [10, 5], strokeWidth: 1.5),
                          child: Container(
                            height: 155,
                            alignment: Alignment.center,
                            child: isFile
                                ? Text(AppString.label.loading, style: AppTextStyle.body)
                                : Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(AppIcons.svg.galleryAdd, colorFilter: AppColors.svg(AppColors.greyIconColor)),
                                        5.height,
                                        Text(AppString.label.addMore, style: AppTextStyle.bodyGreyColor),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ).paddingOnly(right: 5, left: 5, top: 5);
                    } else {
                      return 0.width;
                    }
                  } else {
                    final extension = widget.multiFilesList[index].extension.toLowerCase();
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 1.0,
                      color: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: 160,
                              alignment: Alignment.centerLeft,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  // Preview Icons
                                  buildFilePreviewWidget(widget.multiFilesList[index].path, widget.multiFilesList[index].extension),

                                  //  File name & icon
                                  buildFileIconAndNameWidget(
                                    extension: widget.multiFilesList[index].extension,
                                    fileName: widget.multiFilesList[index].fileName,
                                  ),
                                ],
                              ),
                            ),

                            // Remove Doc
                            GestureDetector(
                              onTap: () {
                                widget.multiFilesList.removeAt(index);
                                commonHapticFeedback();
                                commonHideKeyboard(context);
                                setState(() {});
                              },
                              child: Material(
                                elevation: 2.0,
                                color: Colors.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                child: const Icon(Icons.close, color: Colors.white, size: 20),
                              ).paddingAll(8),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppString.label.attachment, style: AppTextStyle.textFiled),
              Text(AppString.label.docSupport, style: AppTextStyle.body4GreyColor),
              10.height,

              // Add File
              GestureDetector(
                onTap: !isFile
                    ? () {
                        commonHideKeyboard(context);
                        commonBottomSheet(context: context, barrierDismissible: true, screen: const UploadFileAndImageBottomSheet()).then((value) {
                          debugPrint("First Time : $value");
                          isFile = true;
                          if (value != null) {
                            for (int i = 0; i < value.length;) {
                              if (value.length <= 8) {
                                isFile = false;
                                widget.multiFilesList.add(value);
                              } else {
                                isFile = false;
                              }
                              break;
                            }
                          } else {
                            isFile = false;
                          }
                          if (!context.mounted) return;
                          commonHideKeyboard(context);
                        });
                        setState(() {});
                      }
                    : () {},
                child: Row(
                  children: [
                    Expanded(
                      child: DottedBorder(
                        options: RectDottedBorderOptions(color: Colors.black12, dashPattern: [10, 5], strokeWidth: 1.5),
                        child: Container(
                          height: 160,
                          alignment: Alignment.center,
                          child: isFile
                              ? Text(AppString.label.loading, style: AppTextStyle.body2)
                              : SvgPicture.asset(AppIcons.svg.galleryAdd, colorFilter: AppColors.svg(AppColors.greyIconColor)),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox(width: 50)),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  // File Preview Widget
  Widget buildFilePreviewWidget(String path, String? extension) {
    final fileExtension = extension?.toLowerCase();
    switch (fileExtension) {
      case 'jpeg':
      case 'jpg':
      case 'png':
      case 'heic':
        return Image.file(File(path), fit: BoxFit.cover, width: double.infinity, height: 160);
      case 'doc':
      case 'docx':
        return docsGridDesign("docs");
      case 'pdf':
        return docsGridDesign("pdf");
      case 'gif':
        return docsGridDesign("gif");
      case 'bmp':
        return docsGridDesign("bmp");
      case 'mov':
      case 'h.264':
      case 'hevc':
      case 'mp4':
        return docsGridDesign("video");
      case 'mp3':
        return docsGridDesign("mp3");
      case 'zip':
      case 'rar':
        return docsGridDesign("zip");
      case 'xml':
        return docsGridDesign("xml");
      case 'ods':
        return docsGridDesign("ods-file");
      case 'xls':
      case 'xlsx':
        return docsGridDesign("google-sheets");
      case 'txt':
        return docsGridDesign("txt");
      default:
        return const SizedBox.shrink(); // fallback empty widget
    }
  }

  // File Name & Icon
  Widget buildFileIconAndNameWidget({required String extension, required String fileName}) {
    final ext = extension.toLowerCase();

    ImageFilter getImageBlur() {
      const imageExtensions = ['jpeg', 'jpg', 'png', 'heic'];
      return imageExtensions.contains(ext) ? ImageFilter.blur(sigmaY: 20, sigmaX: 20) : ImageFilter.blur(sigmaY: 0, sigmaX: 0);
    }

    Widget buildIcon() {
      switch (ext) {
        case 'doc':
        case 'docx':
          return iconsGridDesign(CupertinoIcons.doc_fill);
        case 'pdf':
          return iconsGridDesign(Icons.picture_as_pdf_rounded);
        case 'jpeg':
        case 'jpg':
        case 'png':
        case 'heic':
          return iconsGridDesign(CupertinoIcons.photo_on_rectangle);
        case 'gif':
          return iconsGridDesign(Icons.gif_box_rounded);
        case 'bmp':
          return iconsGridDesign(Icons.photo_album_outlined);
        case 'mov':
        case 'h.264':
        case 'hevc':
        case 'mp4':
          return iconsGridDesign(CupertinoIcons.videocam_circle_fill);
        case 'mp3':
          return iconsGridDesign(CupertinoIcons.music_note_2);
        case 'txt':
          return iconsGridDesign(CupertinoIcons.doc_richtext);
        default:
          return const Icon(CupertinoIcons.doc_text_fill, color: AppColors.greyIconColor, size: 20);
      }
    }

    TextStyle getTextStyle() {
      const imageExtensions = ['jpeg', 'jpg', 'png', 'heic'];
      return imageExtensions.contains(ext) ? AppTextStyle.bodyGreyColor : AppTextStyle.body;
    }

    return ClipRRect(
      child: BackdropFilter(
        filter: getImageBlur(),
        child: Container(
          color: AppColors.scaffoldBackgroundColor,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              buildIcon(),
              const SizedBox(width: 10),
              Expanded(
                child: Text(fileName, overflow: TextOverflow.ellipsis, style: getTextStyle()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
