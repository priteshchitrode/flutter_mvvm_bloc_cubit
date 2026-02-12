import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // If no text is entered, return the new value as it is.
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Parse the new text as a double, removing commas if they exist.
    double value;
    try {
      value = double.parse(newValue.text.replaceAll(",", ""));
    } catch (e) {
      return oldValue; // Return old value if parsing fails.
    }

    // Format the text in Indian Rupee format without decimal places.
    final formatter = NumberFormat.currency(locale: "en_IN", symbol: "₹", decimalDigits: 0);

    // Append " /monthly" at the end of the formatted text.
    //String newText = "${formatter.format(value)} /monthly";
    String newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
