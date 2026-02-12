import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  DateTimeHelper._();

  /// Returns the current DateTime.
  static DateTime now() {
    return DateTime.now();
  }

  /// Formats DateTime as 'dd/MM/yyyy - hh:mm a'.
  static String getDateTimeFormat(DateTime date) {
    var formatter = DateFormat('dd/MM/yyyy - hh:mm a');
    return formatter.format(date);
  }

  /// Formats time as 'hh:mm a' (AM/PM).
  static String getTimeFormatWithAmOrPm(DateTime date) {
    var formatter = DateFormat('hh:mm a');
    return formatter.format(date);
  }

  /// Formats DateTime as 'dd/MM/yyyy'.
  static String getFormattedDate(DateTime date) {
    var formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(date);
  }

  /// Formats DateTime as 'dd MMM yyyy' (short month name).
  static String getFormattedDateWithShortMonthName(DateTime date) {
    var formatter = DateFormat("dd MMM yyyy");
    return formatter.format(date);
  }

  /// Converts 24-hour time string to localized AM/PM format.
  static String convertToAmPm(String time, BuildContext context) {
    DateTime parsedTime = DateTime.parse('1970-01-01 $time:00');
    String formattedTime = TimeOfDay.fromDateTime(parsedTime).format(context);
    return formattedTime;
  }

  /// Converts 'dd/MM/yyyy' to database format 'yyyy-MM-dd'.
  static String convertToDatabaseFormat(String date) {
    try {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("yyyy-MM-dd").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  /// Converts 'dd/MM/yyyy' string to DateTime.
  static DateTime? convertStringToDateTime(String dateString) {
    try {
      final DateFormat format = DateFormat("dd/MM/yyyy");
      return format.parse(dateString);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return null;
    }
  }

  /// Converts 'dd/MM/yyyy' to DateTime with current time.
  static DateTime convertToDateTimeWithCurrentTime(String date) {
    try {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      DateTime now = DateTime.now();
      return DateTime(parsedDate.year, parsedDate.month, parsedDate.day, now.hour, now.minute, now.second);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return DateTime.now();
    }
  }

  /// Converts 'hh : mm a' string to TimeOfDay.
  static TimeOfDay convertStringToTimeOfDay(String timeString) {
    try {
      final DateFormat format = DateFormat("hh : mm a");
      final DateTime parsedDateTime = format.parse(timeString);
      return TimeOfDay(hour: parsedDateTime.hour, minute: parsedDateTime.minute);
    } catch (e) {
      debugPrint("Error parsing time: $e");
      return TimeOfDay.now();
    }
  }


}
