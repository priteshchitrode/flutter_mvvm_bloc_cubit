import 'package:flutter/services.dart';

class AadhaarInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Add the formatting for Aadhaar number
    String formattedText = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      formattedText += digitsOnly[i];
      if ((i + 1) % 4 == 0 && (i + 1) != digitsOnly.length) {
        formattedText += ' ';
      }
    }

    // Adjust the cursor position
    int selectionIndex = formattedText.length;
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
