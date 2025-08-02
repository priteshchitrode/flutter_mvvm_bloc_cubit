import 'dart:io';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';
import 'app_icons.dart';
import 'app_route.dart';
import 'app_string.dart';
import 'app_text_style.dart';
import 'common_functions.dart';
import 'common_widgets.dart';
import 'upload_file_and_image_bottom_sheet.dart';
import 'upload_images_and_documents/picked_images_and_documents_model.dart';


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
                          onTap: !isFile ? () {
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
                              if(!context.mounted) return;
                              commonHideKeyboard(context);
                            });
                            setState(() {});
                          } : () {},
                          child: DottedBorder(
                            color: AppColors.dividerColor,
                            strokeWidth: 1.5,
                            radius: const Radius.circular(12),
                            borderType: BorderType.RRect,
                            child: Container(
                              height: 155,
                              alignment: Alignment.center,
                              child: isFile ? Text(AppString.label.loading, style: AppTextStyle.body) : Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(AppIcons.svg.galleryAdd, colorFilter: AppColors.svg(AppColors.greyIconColor)),
                                    5.height,
                                    Text(AppString.label.addMore, style: AppTextStyle.bodyGreyColor)
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

                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 1.0,
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        // fit: StackFit.expand,
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 160,
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                if (widget.multiFilesList[index].extension == "jpeg" ||
                                    widget.multiFilesList[index].extension == "PNG" ||
                                    widget.multiFilesList[index].extension == "jpg" ||
                                    widget.multiFilesList[index].extension == "png" ||
                                    widget.multiFilesList[index].extension == "HEIC")
                                  Image.file(File(widget.multiFilesList[index].path), fit: BoxFit.cover, width: double.infinity, height: 160)
                                else if (widget.multiFilesList[index].extension == "docx" || widget.multiFilesList[index].extension == "doc")
                                  docsGridDesign("docs")
                                else if (widget.multiFilesList[index].extension == "pdf")
                                    docsGridDesign("pdf")
                                  else if (widget.multiFilesList[index].extension == "gif")
                                      docsGridDesign("gif")
                                    else if (widget.multiFilesList[index].extension == "bmp")
                                        docsGridDesign("bmp")
                                      else if (widget.multiFilesList[index].extension == "MOV" || widget.multiFilesList[index].extension == "H.264" || widget.multiFilesList[index].extension == "HEVC" || widget.multiFilesList[index].extension == "mp4")
                                          docsGridDesign("video")
                                        else if (widget.multiFilesList[index].extension == "mp3")
                                            docsGridDesign("mp3")
                                          else if (widget.multiFilesList[index].extension == "zip" || widget.multiFilesList[index].extension == "rar")
                                              docsGridDesign("zip")
                                            else if (widget.multiFilesList[index].extension == "xml")
                                                docsGridDesign("xml")
                                              else if (widget.multiFilesList[index].extension == "ods")
                                                  docsGridDesign("ods-file")
                                                else if (widget.multiFilesList[index].extension == "xls" || widget.multiFilesList[index].extension == "xlsx")
                                                    docsGridDesign("google-sheets")
                                                  else if (widget.multiFilesList[index].extension == "txt")
                                                      docsGridDesign("txt"), 
                                ClipRRect(
                                  child: BackdropFilter(
                                    filter: widget.multiFilesList[index].extension == "jpeg" ||
                                        widget.multiFilesList[index].extension == "PNG" ||
                                        widget.multiFilesList[index].extension == "jpg" ||
                                        widget.multiFilesList[index].extension == "png" ||
                                        widget.multiFilesList[index].extension == "HEIC"
                                        ? ImageFilter.blur(sigmaY: 20, sigmaX: 20)
                                        : ImageFilter.blur(sigmaY: 0, sigmaX: 0),
                                    child: Container(
                                      color: AppColors.scaffoldBackgroundColor,
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          if (widget.multiFilesList[index].extension == "docx" || widget.multiFilesList[index].extension == "doc")
                                            iconsGridDesign(CupertinoIcons.doc_fill)
                                          else if (widget.multiFilesList[index].extension == "pdf")
                                            iconsGridDesign(Icons.picture_as_pdf_rounded)
                                          else if (widget.multiFilesList[index].extension == "jpeg" || widget.multiFilesList[index].extension == "PNG" || widget.multiFilesList[index].extension == "jpg" || widget.multiFilesList[index].extension == "png" || widget.multiFilesList[index].extension == "HEIC")
                                              iconsGridDesign(CupertinoIcons.photo_on_rectangle)
                                            else if (widget.multiFilesList[index].extension == "gif")
                                                iconsGridDesign(Icons.gif_box_rounded)
                                              else if (widget.multiFilesList[index].extension == "bmp")
                                                  iconsGridDesign(Icons.photo_album_outlined)
                                                else if (widget.multiFilesList[index].extension == "MOV" || widget.multiFilesList[index].extension == "H.264" || widget.multiFilesList[index].extension == "HEVC" || widget.multiFilesList[index].extension == "mp4")
                                                    iconsGridDesign(CupertinoIcons.videocam_circle_fill)
                                                  else if (widget.multiFilesList[index].extension == "mp3")
                                                      iconsGridDesign(CupertinoIcons.music_note_2)
                                                    else if (widget.multiFilesList[index].extension == "txt")
                                                        iconsGridDesign(CupertinoIcons.doc_richtext)
                                                      else
                                                        const Icon(CupertinoIcons.doc_text_fill, color: AppColors.greyIconColor, size: 20),
                                          10.width,
                                          Expanded(
                                            child: Text(widget.multiFilesList[index].fileName,
                                                overflow: TextOverflow.ellipsis,
                                                style: widget.multiFilesList[index].extension == "jpeg" ||
                                                    widget.multiFilesList[index].extension == "PNG" ||
                                                    widget.multiFilesList[index].extension == "jpg" ||
                                                    widget.multiFilesList[index].extension == "png" ||
                                                    widget.multiFilesList[index].extension == "HEIC"
                                                    ? AppTextStyle.bodyGreyColor
                                                    : AppTextStyle.body,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
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
            GestureDetector(
              onTap: !isFile ? () {
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
                  if(!context.mounted) return;
                  commonHideKeyboard(context);
                });
                setState(() {});
              } : () {},
              child: Row(
                children: [
                  Expanded(
                    child: DottedBorder(
                      color:  Colors.black12,
                      strokeWidth: 1.5,
                      radius:  const Radius.circular(12),
                      borderType: BorderType.RRect,
                      child: Container(
                        height: 160,
                        alignment: Alignment.center,
                        child: isFile ? Text(AppString.label.loading, style: AppTextStyle.body2) :  SvgPicture.asset(AppIcons.svg.galleryAdd, colorFilter: AppColors.svg(AppColors.greyIconColor),),
                      ),
                    ),
                  ),
                   const Expanded(child: SizedBox(width: 50))
                ],
              ),
            ),
          ],
        );

      }
    });
  }
}
