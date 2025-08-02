import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'app_colors.dart';
import 'app_string.dart';
import 'app_text_style.dart';
import 'common_widgets.dart';

@immutable
class ShowMultipleDocumentFiles extends StatefulWidget {
  final List multiFilesList;
  const ShowMultipleDocumentFiles({super.key, required this.multiFilesList});

  @override
  State<ShowMultipleDocumentFiles> createState() => _ShowMultipleDocumentFilesState();
}

class _ShowMultipleDocumentFilesState extends State<ShowMultipleDocumentFiles> {
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
                5.height,

                // Documents View
                MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: widget.multiFilesList.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: (){
                        if(widget.multiFilesList[index]["extension"] == "pdf"){
                         // Navigator.of(context).push(commonRoute(PdfViewerScreen(pdf:  widget.multiFilesList[index]["path"])));
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 1.0,
                        color: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 160,
                            alignment: Alignment.centerLeft,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                if (widget.multiFilesList[index]["extension"] == "jpeg" ||
                                    widget.multiFilesList[index]["extension"] == "PNG" ||
                                    widget.multiFilesList[index]["extension"] == "png" ||
                                    widget.multiFilesList[index]["extension"] == "jpg" ||
                                    widget.multiFilesList[index]["extension"] == "png" ||
                                    widget.multiFilesList[index]["extension"] == "HEIC")
                                  commonCacheNetworkImage(path : widget.multiFilesList[index]["path"], fit: BoxFit.cover, width: double.infinity, height: 160)
                                else if (widget.multiFilesList[index]["extension"] == "docx" || widget.multiFilesList[index]["extension"] == "doc")
                                  docsGridDesign("docs")
                                else if (widget.multiFilesList[index]["extension"] == "pdf")
                                    docsGridDesign("pdf")
                                  else if (widget.multiFilesList[index]["extension"] == "gif")
                                      docsGridDesign("gif")
                                    else if (widget.multiFilesList[index]["extension"] == "bmp")
                                        docsGridDesign("bmp")
                                      else if (widget.multiFilesList[index]["extension"] == "MOV" || widget.multiFilesList[index]["extension"] == "H.264" || widget.multiFilesList[index]["extension"] == "HEVC" || widget.multiFilesList[index]["extension"] == "mp4")
                                          docsGridDesign("video")
                                        else if (widget.multiFilesList[index]["extension"] == "mp3")
                                            docsGridDesign("mp3")
                                          else if (widget.multiFilesList[index]["extension"] == "zip" || widget.multiFilesList[index]["extension"] == "rar")
                                              docsGridDesign("zip")
                                            else if (widget.multiFilesList[index]["extension"] == "xml")
                                                docsGridDesign("xml")
                                              else if (widget.multiFilesList[index]["extension"] == "ods")
                                                  docsGridDesign("ods-file")
                                                else if (widget.multiFilesList[index]["extension"] == "xls" || widget.multiFilesList[index]["extension"] == "xlsx")
                                                    docsGridDesign("google-sheets")
                                                  else if (widget.multiFilesList[index]["extension"] == "txt")
                                                      docsGridDesign("txt"),
                                ClipRRect(
                                  child: BackdropFilter(
                                    filter: widget.multiFilesList[index]["extension"] == "jpeg" ||
                                        widget.multiFilesList[index]["extension"] == "PNG" ||
                                        widget.multiFilesList[index]["extension"] == "jpg" ||
                                        widget.multiFilesList[index]["extension"] == "png" ||
                                        widget.multiFilesList[index]["extension"] == "HEIC"
                                        ? ImageFilter.blur(sigmaY: 20, sigmaX: 20)
                                        : ImageFilter.blur(sigmaY: 0, sigmaX: 0),
                                    child: Container(
                                      color: AppColors.scaffoldBackgroundColor,
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          if (widget.multiFilesList[index]["extension"] == "docx" || widget.multiFilesList[index]["extension"] == "doc")
                                            iconsGridDesign(CupertinoIcons.doc_fill)
                                          else if (widget.multiFilesList[index]["extension"] == "pdf")
                                            iconsGridDesign(Icons.picture_as_pdf_rounded)
                                          else if (widget.multiFilesList[index]["extension"] == "jpeg" || widget.multiFilesList[index]["extension"] == "PNG" || widget.multiFilesList[index]["extension"] == "jpg" || widget.multiFilesList[index]["extension"] == "png" || widget.multiFilesList[index]["extension"] == "HEIC")
                                              iconsGridDesign(CupertinoIcons.photo_on_rectangle)
                                            else if (widget.multiFilesList[index]["extension"] == "gif")
                                                iconsGridDesign(Icons.gif_box_rounded)
                                              else if (widget.multiFilesList[index]["extension"] == "bmp")
                                                  iconsGridDesign(Icons.photo_album_outlined)
                                                else if (widget.multiFilesList[index]["extension"] == "MOV" || widget.multiFilesList[index]["extension"] == "H.264" || widget.multiFilesList[index]["extension"] == "HEVC" || widget.multiFilesList[index]["extension"] == "mp4")
                                                    iconsGridDesign(CupertinoIcons.videocam_circle_fill)
                                                  else if (widget.multiFilesList[index]["extension"] == "mp3")
                                                      iconsGridDesign(CupertinoIcons.music_note_2)
                                                    else if (widget.multiFilesList[index]["extension"] == "txt")
                                                        iconsGridDesign(CupertinoIcons.doc_richtext)
                                                      else
                                                        const Icon(CupertinoIcons.doc_text_fill, color: AppColors.greyIconColor, size: 20),
                                          10.width,
                                          Expanded(
                                            child: Text(widget.multiFilesList[index]["fileName"],
                                              overflow: TextOverflow.ellipsis,
                                              style: widget.multiFilesList[index]["extension"] == "jpeg" ||
                                                  widget.multiFilesList[index]["extension"] == "PNG" ||
                                                  widget.multiFilesList[index]["extension"] == "jpg" ||
                                                  widget.multiFilesList[index]["extension"] == "png" ||
                                                  widget.multiFilesList[index]["extension"] == "HEIC"
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
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return Container();
          }
        },
    );
  }
}
