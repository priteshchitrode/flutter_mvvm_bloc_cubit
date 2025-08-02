import 'dart:io';
import 'package:flutter_mvvm_bloc_cubit/utils/app_string.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/toast_messages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'picked_images_and_documents_model.dart';

class ImagePickerFrom {
  static final ImagePicker _picker = ImagePicker();

  static const List<String> _supportedExtensions = ['PNG', 'jpg', 'jpeg', 'png', 'heif', 'heic', 'HEIF', 'HEIC'];
  static const int _maxFileSize = 8 * 1024 * 1024; // 8MB

  // Pick image from Camera
  static Future<PickedImageModel?> fromCamera() async {
    return await _pickImage(ImageSource.camera);
  }

  // Pick image from Gallery
  static Future<PickedImageModel?> fromGallery() async {
    return await _pickImage(ImageSource.gallery);
  }

  // Shared method for image picking
  static Future<PickedImageModel?> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      ToastMessages.alert(message: AppString.label.noImageSelected);
      return null;
    }

    final File file = File(pickedFile.path);
    final String extension = path.extension(pickedFile.path).replaceFirst('.', '').toLowerCase();

    if (!_isValidImage(file, extension)) {
      return null;
    }

    return PickedImageModel(
      fileName: path.basename(file.path),
      path: file.path,
      extension: extension,
      dateTime: DateTime.now().toIso8601String(),
    );

  }

  // Image validation
  static bool _isValidImage(File image, String extension) {
    if (!_supportedExtensions.contains(extension)) {
      ToastMessages.alert(message: AppString.label.imageSupport);
      return false;
    }

    final int fileSize = image.lengthSync();
    if (fileSize > _maxFileSize) {
      ToastMessages.alert(message: AppString.label.imageSize);
      return false;
    }

    return true;
  }
}
