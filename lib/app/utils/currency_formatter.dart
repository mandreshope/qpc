import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

//    final formatter = NumberFormat.simpleCurrency();
    final formatter = NumberFormat("#,###");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class CustomTextInputFormatter extends TextInputFormatter {
  CustomTextInputFormatter({
    required this.separator,
    required this.decimalSeparator,
  });
  static List<String> nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

  String get logId => runtimeType.toString();

  final String separator;
  final String decimalSeparator;

  ///
  /// Parse the masked String value back to double
  /// For example if sep = " " and decSep = ","
  /// - "5 900,56" becomes 5900.56
  /// - "5 900.56" becomes null
  /// - "5,900.56" becomes null
  /// - "asdf560.345" becomes null
  double? parse(String currentValue) {
    String numStr = currentValue
        .replaceAll(separator, '')
        .replaceAll(decimalSeparator, '.');
    return double.tryParse(numStr);
  }

  ///  Take double for formatting
  String? applyMask(double number) {
    number = double.parse(number.toStringAsFixed(4));
    final newValueText = number.toString();
    List<String> twoParts = newValueText.split('.');
    if (twoParts.length > 1 && twoParts[1] == "0") {
      twoParts = [twoParts[0]];
    }
    return _applyMask(twoParts);
  }

  /// When this returns null, it means that nothing has changed
  String? _applyMaskInternal(String newValueText) {
    assert(separator != decimalSeparator);
    if (!_isValidInput(newValueText)) return null;

    List<String> twoParts =
        newValueText.replaceAll(separator, '').split(decimalSeparator);
    return _applyMask(twoParts);
  }

  /// Take String partially formatted with
  /// decimal and thousand separator
  /// strictly equal to the library setup,
  /// this will output undefined behaviour
  String? _applyMask(List<String> twoParts) {
    List<String> integerChars = twoParts[0].split('');

    // Removing leading zeros
    // This code works however, when user changes form 2,000 to 1,000
    // by deleting the 2, the 000 will be removed
    // because they are considered as leading zeros and it will be 10
    if (integerChars.length > 1) {
//        integerChars = _removeLeadingZeros(_integerChars);
    }

    if (integerChars.length == 0) {
      integerChars = ["0"];
    }
    // print("$logId allChars $twoParts integerCharss $integerChars");
    List<String> decimalChars = [];
    if (twoParts.length == 2) {
      decimalChars = twoParts[1].split('');
      if (decimalChars.length > 2) {
        return null;
      }
    } else if (twoParts.length > 2) {
      return null;
    }
    String newString = '';
    // print("$logId $integerChars");
    for (int i = integerChars.length - 1; i >= 0; i--) {
      if ((integerChars.length - 1 - i) % 3 == 0 &&
          i < integerChars.length - 1 &&
          integerChars.length > 3) newString = separator + newString;
      newString = integerChars[i] + newString;
//        print("$logId $newString");
    }
    if (twoParts.length > 1) {
      newString += decimalSeparator + decimalChars.join("");
    }
    return newString;
  }

  bool _isValidInput(String stringTypedByUser) {
    for (final s in stringTypedByUser.split("")) {
      if (!nums.contains(s) && ![separator, decimalSeparator].contains(s)) {
        return false;
      }
    }
    return true;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // print('$logId formatEditUpdate');
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (oldValue == newValue) {
      // print('$logId new value equal old value');
      return oldValue;
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final newString = _applyMaskInternal(newValue.text);
      if (newString == null) {
        return oldValue;
      }

      final commasAfter = separator.allMatches(newString).length;
      final commasBefore = separator.allMatches(oldValue.text).length;
      int offset = newValue.selection.end + commasAfter - commasBefore;

      // handling edge case 0. from . only input
      if (newString == "0$decimalSeparator") {
        offset = newString.length;
      }
      // print("$logId offset $offset $newString");
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: offset,
        ),
      );
    } else {
      return newValue;
    }
  }
}
