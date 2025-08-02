import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  DateTimeHelper._();

  static DateTime now() {
    return DateTime.now();
  }

  static String getDateTimeFormat(DateTime date) {
    var formatter = DateFormat('dd/MM/yyyy - hh:mm a');
    return formatter.format(date);
  }

  static String getTimeFormatWithAmOrPm(DateTime date) {
    var formatter = DateFormat('hh:mm a');
    return formatter.format(date);
  }

  static String getFormattedDate(DateTime date) {
    var formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(date);
  }

  static String getFormattedDateWithShortMonthName(DateTime date) {
    var formatter = DateFormat("dd MMM yyyy");
    return formatter.format(date);
  }

  static String convertToAmPm(String time, BuildContext context) {
    DateTime parsedTime = DateTime.parse('1970-01-01 $time:00');
    String formattedTime = TimeOfDay.fromDateTime(parsedTime).format(context);
    return formattedTime;
  }

  static String convertToDatabaseFormat(String date) {
    try {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      return DateFormat("yyyy-MM-dd").format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  static DateTime? convertStringToDateTime(String dateString) {
    try {
      // Define input format (DD/MM/YYYY)
      final DateFormat format = DateFormat("dd/MM/yyyy");
      return format.parse(dateString);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return null; // Return null if the parsing fails
    }
  }

  /// Input Date Format : dd/MM/yyyy
  static DateTime convertToDateTimeWithCurrentTime(String date) {
    try {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(date);
      DateTime now = DateTime.now();
      return DateTime(parsedDate.year, parsedDate.month, parsedDate.day, now.hour, now.minute, now.second);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return DateTime.now(); // Return current date-time in case of error
    }
  }

  /// Input Format hh : mm a , example- 05 : 15 PM
  static TimeOfDay convertStringToTimeOfDay(String timeString) {
    try {
      final DateFormat format = DateFormat("hh : mm a");
      final DateTime parsedDateTime = format.parse(timeString);
      return TimeOfDay(hour: parsedDateTime.hour, minute: parsedDateTime.minute);
    } catch (e) {
      debugPrint("Error parsing time: $e");
      return TimeOfDay.now(); // Return current time if parsing fails
    }
  }

}
