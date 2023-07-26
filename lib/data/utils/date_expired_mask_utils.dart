import 'package:flutter/services.dart';

import 'number_clearer_utils.dart';

class DateExpiredMaskFormatter extends TextInputFormatter {

  DateExpiredMaskFormatter();

  final String pattern = 'AA/AA';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue) {

      return getFormattedValue(newValue, oldValue.text);
    }

  TextEditingValue getFormattedValue(TextEditingValue newValue, String oldValue) {
    var sizeClipped = newValue.text.length > pattern.length
        ? newValue.text.substring(0, pattern.length)
        : newValue.text;

    var clearedText = getNumberCleared(sizeClipped, isUserEntered: true);
    var formattedText = format(clearedText);

    return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: newValue.selection.baseOffset > pattern.length
                    ? pattern.length
                    : _calculateOffset(newValue)
        )
    );
  }

  String format(String text) {
    var patternArr = [];
    var textArr = [];
    var textI = 0;

    pattern
        .split('')
        .forEach((ch) => patternArr.add(ch));

    text
        .split('')
        .forEach((ch) => textArr.add(ch));

    if (textArr.isNotEmpty
        && textArr.firstOrNull != '1'
        && textArr.firstOrNull != '0') {
      textArr.insert(0, '0');
    }

    for (var patternI=0; patternI<patternArr.length; patternI++) {
      if (patternArr[patternI] == 'A' && textI < textArr.length) {
        patternArr[patternI] = textArr[textI];

      } else {
        continue;
      }
      textI++;
    }

    return patternArr.join().replaceAll('A', '');
  }

  int _calculateOffset(TextEditingValue newValue) {
    var newCursorPosition = newValue.selection.end;

    if (newCursorPosition == 1
        && !newValue.text.startsWith('0')
        && !newValue.text.startsWith('1')) {
      newCursorPosition +=1;
    }

    for (var patternI = 0; patternI < newValue.selection.end; patternI++) {
      if (pattern[patternI] != 'A'
          && pattern[patternI] != newValue.text[patternI]
      ) {
        newCursorPosition += 1;
      }
    }

    return newCursorPosition;
  }
}
