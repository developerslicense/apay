import 'package:apay/data/utils/mask_utils.dart';
import 'package:apay/data/utils/number_clearer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void testMaskFormatter() {
  test('MaskFormatter', () {

    _testPhone('+7 (705) 123-45-67');
    _testPhone('8 (705) 123-45-67');
    _testPhone('+7(705)123-45-67');
    _testPhone('+7705123-45-67');
    _testPhone('+77051234567');
    _testPhone('7 (705) 123-45-67');

    _testPhone('7051234567');
    _testPhone('+ (705) 123-45-67');

    expect(_initMaskFormatterAndFormat('XXXXXAAAA', 'S1234567B'), 'XXXXXS123');
    expect(_initMaskFormatterAndFormat('+7 (AAA) AAA AA AA', '7051234567'), '+7 (705) 123 45 67');
    expect(_initMaskFormatterAndFormat('+7 (AAA) AAA AA AA', '7051234567'), '+7 (705) 123 45 67');
    expect(_initMaskFormatterAndFormat('+7 (AAA)-AAA-AA-AA', '7051234567'), '+7 (705)-123-45-67');
    expect(_initMaskFormatterAndFormat('AAAA*AAAA*AAAA*AAAA', '1234567890123456'), '1234*5678*9012*3456');
    expect(_initMaskFormatterAndFormat('AAAA AAAA AAAA AAAA', '1234567890123456'), '1234 5678 9012 3456');

    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '', '1', 0, 1), 1);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234', '5123 4', 0, 1), 1);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234', '1234 5', 4, 5), 6);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5', '1234 56', 6, 7), 8);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 56', '1234 567', 7, 8), 9);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 567', '1234 5678', 8, 9), 10);

    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 0, 1), 1);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 1, 2), 2);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 2, 3), 3);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 3, 4), 4);

    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 4, 5), 6);//! плюс один отступ
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 5, 6), 7);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 6, 7), 8);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 7, 8), 9);
    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 8, 9), 10);

    expect(_initNewCursorPosition('AAAA AAAA AAAA AAAA', '1234 5678', '1234 5678 9', 9, 10), 12);//! плюс один отступ
  });
}

void _testPhone(String text) {
    var maskFormatterPhone = _initMaskFormatter('+7 (AAA)-AAA-AA-AA');

    var cleared = getNumberCleared(text, isPhoneNumber: true);
    var phone = maskFormatterPhone.format(cleared);
    expect(phone, '+7 (705)-123-45-67');
}

String _initMaskFormatterAndFormat(
    String pattern,
    String text
) => _initMaskFormatter(pattern).format(text);

int _initNewCursorPosition(
    String mask,
    String textOld,
    String textNew,
    int oldCursorPosition,
    int newCursorPosition,
) {
  var maskFormatter = _initMaskFormatter(mask);

  return maskFormatter.getFormattedValue(
      TextEditingValue(
          text: textNew,
          selection: TextSelection.collapsed(offset: newCursorPosition)
      ),
      textOld
  ).selection.baseOffset;
}

MaskFormatter _initMaskFormatter(String pattern) {
    return MaskFormatter(pattern);
}
