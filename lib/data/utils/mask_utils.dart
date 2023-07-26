import 'package:flutter/services.dart';

import 'number_clearer_utils.dart';

/// MaskFormatter("XXXXXAAAA").format("S1234567B") // XXXXX567B
/// MaskFormatter("XX.XXX.AAAA").format("S1234567B") // XX.XXX.567B
/// MaskFormatter("**.***.AAAA").format("S1234567B") // **.***.567B
/// MaskFormatter("AA-AAA-AAAA").format("123456789") // 12-345-6789
///
/// Принимает только очищенные от мусора числа. Если нужно очистить - используй
/// getNumberCleared, getNumberClearedWithMaxSymbol

class MaskFormatter extends TextInputFormatter {
  String pattern;

  MaskFormatter(this.pattern);

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
