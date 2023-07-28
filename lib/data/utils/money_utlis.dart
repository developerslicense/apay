import 'package:intl/intl.dart';
import 'dart:developer' as developer;

import '../constants/strings.dart';

import 'base_strings.dart';
import 'number_clearer_utils.dart';

class Money {
  int amount = 0;
  String currency = kzt;

  Money(int amount, {String currency = kzt}) {
    this.amount = int.parse(getNumberClearedWithMaxSymbol(amount.toString()));
  }

  Money.initString({String? amount, String currency = kzt}) {
    var temp = double.parse(getNumberClearedWithMaxSymbol(amount?.toString()));
    this.amount = temp.toInt();
  }

  Money.initDouble({double? amount, String currency = kzt}) {
    var temp = double.parse(getNumberClearedWithMaxSymbol(amount?.toString()));
    this.amount = temp.toInt();
  }

  Money.initMoney(Money? amount) {
    var temp = double.parse(getNumberClearedWithMaxSymbol(amount?.amount.toString()));
    this.amount = temp.toInt();
    currency = amount?.currency ?? kzt;
  }

  String getFormatted() {
    return getMoneyFormatted(amount.toString());
  }
}

String getMoneyFormatted(String amount, {int decimalDigits = 0}) {
  try {
    var temp = double.parse(getNumberClearedWithMaxSymbol(amount));
    return NumberFormat
        .simpleCurrency(locale: 'KK-kk', decimalDigits: decimalDigits)
        .format(temp);
  } catch (e, m) {
    developer.log('getMoneyFormatted error: $e | $m');
    return '0';
  }
}