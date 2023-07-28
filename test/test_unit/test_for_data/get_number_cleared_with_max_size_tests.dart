import 'package:apay/airba_pay_sdk.dart';
import 'package:apay/data/constants/strings.dart';
import 'package:apay/data/utils/number_clearer_utils.dart';
import 'package:flutter_test/flutter_test.dart';

String _testGetNumberCleared(String? amount, {String? lang, bool isUserEntered = false}) {
  return getNumberClearedWithMaxSymbol(amount, lang: lang, isUserEntered: isUserEntered);
}

void testsGetNumberClearedWithMaxSize() {

  test('тест getMoneyCleared', () {
    expect(_testGetNumberCleared('±§!@#\$&*;:[]`~%^&100000.0'), '100000.0');
    expect(_testGetNumberCleared('100000&*()^.0'), '100000.0');
    expect(_testGetNumberCleared('100000&*()^,0'), '100000.0');
    expect(_testGetNumberCleared('100000&*()^.00'), '100000.00');
    expect(_testGetNumberCleared('100000&*()^,00'), '100000.00');
    expect(_testGetNumberCleared('100000&*()^'), '100000');
    expect(_testGetNumberCleared('1000&*()^00'), '100000');

    expect(_testGetNumberCleared('±§!@#\$&*;:[]`~%^&100000.0', isUserEntered: true), '1000000');
    expect(_testGetNumberCleared('100000&*()^.0', isUserEntered: true), '1000000');
    expect(_testGetNumberCleared('100000&*()^,0', isUserEntered: true), '1000000');
    expect(_testGetNumberCleared('100000&*()^.00', isUserEntered: true), '10000000');
    expect(_testGetNumberCleared('100000&*()^,00', isUserEntered: true), '10000000');
    expect(_testGetNumberCleared('100000&*()^', isUserEntered: true), '100000');
    expect(_testGetNumberCleared('1000&*()^00', isUserEntered: true), '100000');

    expect(_testGetNumberCleared(' 1 234 567 890 ${kzt}', isUserEntered: true), '1234567890');
    expect(_testGetNumberCleared(' 1 234 567 890 ${kzt}', isUserEntered: false), '1234567890');

    _testWithLang(AirbaPaySdkLang.kz.lang);
    _testWithLang(AirbaPaySdkLang.ru.lang);
    _testWithLang('en');

    _testWithMinus(AirbaPaySdkLang.ru.lang);
    _testWithMinus(AirbaPaySdkLang.kz.lang);
    _testWithMinus('en');

    _testCyrillic(AirbaPaySdkLang.kz.lang);
    _testCyrillic(AirbaPaySdkLang.ru.lang);

  });
}

void _testCyrillic(String lang) {
  expect(_testGetNumberCleared('100000&*()^,0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000&*()^,00', lang: lang), '100000.00');
  expect(_testGetNumberCleared('100000&*()^,0', lang: lang, isUserEntered: true), '1000000');
  expect(_testGetNumberCleared('100000&*()^,00', lang: lang, isUserEntered: true), '10000000');

}

void _testWithLang(String lang) {
  expect(_testGetNumberCleared('±§!@#\$&*;:[]`~%^&100000.0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('1000±§!@#\$&*;:[]`~%^&00.0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&.0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000.±§!@#\$&*;:[]`~%^&0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[].`~%^&0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&.', lang: lang), '100000.');
  expect(_testGetNumberCleared('10000.1±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.1');
  expect(_testGetNumberCleared('10000.0±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.0');
  expect(_testGetNumberCleared('10000.10±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.10');
  expect(_testGetNumberCleared('10000.01±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.01');
  expect(_testGetNumberCleared('10000.00±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.00');
  expect(_testGetNumberCleared('10000.000±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.00');
  expect(_testGetNumberCleared('10000.0000±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.00');
  expect(_testGetNumberCleared('10000.00000±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.00');
  expect(_testGetNumberCleared('10000.001000±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.00');
  expect(_testGetNumberCleared('10000.0000000000±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.00');
  expect(_testGetNumberCleared('10000.00000000001±§!@#\$&*;:[]`~%^&.', lang: lang), '10000.00');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&..', lang: lang), '100000.');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&...', lang: lang), '100000.');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&....', lang: lang), '100000.');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&..0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&..00', lang: lang), '100000.00');
  expect(_testGetNumberCleared('100000±§!@#\$&*;:[]`~%^&.0.00', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000&*()^.0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('100000&*()^.00', lang: lang), '100000.00');
  expect(_testGetNumberCleared('100000&*()^', lang: lang), '100000');
  expect(_testGetNumberCleared('1000&*()^00', lang: lang), '100000');
  expect(_testGetNumberCleared('1000000000', lang: lang), '1000000000');
  expect(_testGetNumberCleared('1000000000.0', lang: lang), '1000000000.0');
  expect(_testGetNumberCleared('1000000000.00', lang: lang), '1000000000.00');
  expect(_testGetNumberCleared('10000000000.00', lang: lang), '1000000000');
  expect(_testGetNumberCleared('100000000000.00', lang: lang), '1000000000');
  expect(_testGetNumberCleared('1000000000000.00', lang: lang), '1000000000');
  expect(_testGetNumberCleared('1000000000000.000', lang: lang), '1000000000');

  expect(_testGetNumberCleared('±§!@#\$&*;:[]`~%^&100000.0', lang: lang, isUserEntered: true), '1000000');
  expect(_testGetNumberCleared('100000&*()^.0', lang: lang, isUserEntered: true), '1000000');
  expect(_testGetNumberCleared('100000nJтЕтiЩда.0', lang: lang, isUserEntered: true), '1000000');
  expect(_testGetNumberCleared('100000&*()^.00', lang: lang, isUserEntered: true), '10000000');
  expect(_testGetNumberCleared('100000PhjnтлОР.00', lang: lang, isUserEntered: true), '10000000');

  expect(_testGetNumberCleared('100000&*()^', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1000&*()^00', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1000zXьЛ00', lang: lang, isUserEntered: true), '100000');
}

void _testWithMinus(String lang) {
  expect(_testGetNumberCleared('-100000', lang: lang), '-100000');
  expect(_testGetNumberCleared('--100000', lang: lang), '-100000');
  expect(_testGetNumberCleared('--100-000', lang: lang), '-100000');
  expect(_testGetNumberCleared('-100000.0', lang: lang), '-100000.0');
  expect(_testGetNumberCleared('-1000zXьЛ00', lang: lang), '-100000');
  expect(_testGetNumberCleared('1-000zXьЛ00', lang: lang), '100000');
  expect(_testGetNumberCleared('1000-zXьЛ00', lang: lang), '100000');
  expect(_testGetNumberCleared('1000zXьЛ-00', lang: lang), '100000');
  expect(_testGetNumberCleared('1000zXьЛ00-', lang: lang), '100000');
  expect(_testGetNumberCleared('1000zXьЛ00.-', lang: lang), '100000.');
  expect(_testGetNumberCleared('1000zXьЛ00.-0', lang: lang), '100000.0');
  expect(_testGetNumberCleared('1000zXьЛ00.-00', lang: lang), '100000.00');
  expect(_testGetNumberCleared('1000zXьЛ00.-0-0', lang: lang), '100000.00');
  expect(_testGetNumberCleared('-1000zXьЛ00.-0-0', lang: lang), '-100000.00');

  expect(_testGetNumberCleared('-100000', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('--100000', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('--100-000', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('-100000.0', lang: lang, isUserEntered: true), '1000000');
  expect(_testGetNumberCleared('-1000zXьЛ00', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1-000zXьЛ00', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1000-zXьЛ00', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1000zXьЛ-00', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1000zXьЛ00-', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1000zXьЛ00.-', lang: lang, isUserEntered: true), '100000');
  expect(_testGetNumberCleared('1000zXьЛ00.-0', lang: lang, isUserEntered: true), '1000000');
  expect(_testGetNumberCleared('1000zXьЛ00.-00', lang: lang, isUserEntered: true), '10000000');
  expect(_testGetNumberCleared('1000zXьЛ00.-0-0', lang: lang, isUserEntered: true), '10000000');
  expect(_testGetNumberCleared('-1000zXьЛ00.-0-0', lang: lang, isUserEntered: true), '10000000');

}
