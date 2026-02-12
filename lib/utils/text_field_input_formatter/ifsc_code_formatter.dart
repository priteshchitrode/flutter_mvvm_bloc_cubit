import 'package:flutter/services.dart';

class IFSCCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove non-alphanumeric characters
    String alphanumericOnly = newValue.text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');

    // Limit to 11 characters (IFSC length)
    if (alphanumericOnly.length > 11) {
      alphanumericOnly = alphanumericOnly.substring(0, 11);
    }

    // Convert all to uppercase
    String formattedText = alphanumericOnly.toUpperCase();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
