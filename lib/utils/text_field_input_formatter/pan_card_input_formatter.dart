import 'package:flutter/services.dart';

class PANCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-alphanumeric characters
    String alphanumericOnly = newValue.text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');

    // Ensure length does not exceed 10 characters
    if (alphanumericOnly.length > 10) {
      alphanumericOnly = alphanumericOnly.substring(0, 10);
    }

    // Convert first 5 and last character to uppercase
    String formattedText = '';
    for (int i = 0; i < alphanumericOnly.length; i++) {
      if (i < 5 || i == 9) {
        formattedText += alphanumericOnly[i].toUpperCase();
      } else {
        formattedText += alphanumericOnly[i];
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
