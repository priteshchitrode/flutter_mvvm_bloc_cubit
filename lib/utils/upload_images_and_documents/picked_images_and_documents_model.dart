class PickedImageModel {
  final String fileName;
  final String path;
  final String extension;
  final String dateTime;

  PickedImageModel({
    required this.fileName,
    required this.path,
    required this.extension,
    required this.dateTime,
  });

  factory PickedImageModel.fromJson(Map<String, dynamic> json) {
    return PickedImageModel(
      fileName: json['fileName'],
      path: json['path'],
      extension: json['extension'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'path': path,
      'extension': extension,
      'dateTime': dateTime,
    };
  }

  @override
  String toString() {
    return 'PickedImageModel(fileName: $fileName, path: $path, extension: $extension, dateTime: $dateTime)';
  }
}
