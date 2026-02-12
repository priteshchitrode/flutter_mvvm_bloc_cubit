import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/toast_messages.dart';
import 'picked_images_and_documents_model.dart';

Future<List<PickedImageModel>?> pickMultipleFile({required BuildContext context, required String type}) async {
  const supportedExtensions = [
    'jpg',
    'jpeg',
    'gif',
    'bmp',
    'pdf',
    'png',
    'doc',
    'docx',
    'txt',
    'xls',
    'xlsx',
    'ods',
    'zip',
    'rar',
    'xml',
    'mp4',
    'mp3',
    'hevc',
    'h.264',
    'mov',
    'heic',
  ];

  try {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true, withData: false, withReadStream: false);

    if (result == null || result.files.isEmpty) {
      if (context.mounted) {
        ToastMessages.alert(message: "No files have been selected");
      }
      return null;
    }

    final validFiles = <PickedImageModel>[];

    for (final file in result.files) {
      final extension = (file.extension ?? '').toLowerCase();
      if (!supportedExtensions.contains(extension)) {
        if (context.mounted) {
          ToastMessages.alert(message: "Invalid file format: .$extension");
        }
        return null; // Early return on first invalid file
      }
      if (file.path == null) continue;

      validFiles.add(PickedImageModel(fileName: file.name, path: file.path!, extension: extension, dateTime: DateTime.now().toIso8601String()));
    }

    return validFiles;
  } catch (e) {
    debugPrint("File Picker error: $e");
    return null;
  }
}
