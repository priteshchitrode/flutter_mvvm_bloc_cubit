import 'package:intl/intl.dart';

extension NullableStringExtensions on String? {
  /// Returns the string value if it is not null, otherwise returns an empty string.
  String orEmpty() => this ?? '';

  /// Returns the string value if it is not null, otherwise returns an empty string.
  String orNotAvailable() => (this == null || this == 'null' || this == '') ? 'Not Available' : this!;

  /// Returns the string value if it is not null, otherwise returns a specified default value.
  String orDefault(String defaultValue) => this ?? defaultValue;

  /// Trims the string if it is not null, otherwise returns null.
  String? trimOrNull() => this?.trim();

  /// Checks if the string is either null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Checks if the string is either null or contains only whitespace.
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  String get toInt => "${int.parse(this ?? "0")}";

  String dateFormated(String format) => (this == null || this == 'null' || this == '') ? 'Not Available' : DateFormat(format).format(DateFormat('dd/MM/yyyy').parse(this!));

  String dateFormatedYyyyMMdd(String format) => (this == null || this == 'null' || this == '') ? 'Not Available' : DateFormat(format).format(DateFormat('yyyy-MM-dd').parse(this!));
}

extension NullableIntExtensions on int? {
  /// Returns the integer value if it is not null, otherwise returns zero.
  int orZero() => this ?? 0;

  /// Returns the integer value if it is not null, otherwise returns a specified default value.
  int orDefault(int defaultValue) => this ?? defaultValue;

  /// Checks if the integer is null or zero.
  bool get isNullOrZero => this == null || this == 0;
}

extension NullableBoolExtensions on bool? {
  /// Returns the integer value if it is not null, otherwise returns zero.
  bool orFalse() => this ?? false;

  /// Checks if the integer is null or zero.
  bool get isNullOrZero => this == null || this == 0;
}

extension NullableDoubleExtensions on double? {
  /// Returns the double value if it is not null, otherwise returns zero.
  double orZero() => this ?? 0.0;

  /// Returns the double value if it is not null, otherwise returns a specified default value.
  double orDefault(double defaultValue) => this ?? defaultValue;

  /// Checks if the double is null or zero.
  bool get isNullOrZero => this == null || this == 0.0;
}

extension NullableListExtensions<T> on List<T>? {
  /// Returns the list if it is not null, otherwise returns an empty list.
  List<T> orEmpty() => this ?? [];

  /// Returns the list if it is not null, otherwise returns a specified default list.
  List<T> orDefault(List<T> defaultValue) => this ?? defaultValue;

  /// Checks if the list is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension NullableExtensions<T> on T? {
  /// Returns the value if it is not null, otherwise returns a specified default value.
  T orDefault(T defaultValue) => this ?? defaultValue;

  /// Checks if the value is null.
  bool get isNull => this == null;

  /// Executes a callback function if the value is not null.
  void ifNotNull(void Function(T value) callback) {
    if (this != null) {
      callback(this as T);
    }
  }
}


