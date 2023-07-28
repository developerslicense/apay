import 'dart:developer' as developer;

import '../constants/regex.dart';

String getNumberCleared(
    String? amount,
    { String? lang,
      bool isUserEntered = false,
      bool isPhoneNumber = false }) {
  String amountLocaleCleaned = _clearNumberForLocale(amount, lang, isUserEntered, isPhoneNumber);
  return _clearNumberMaxSymbols(amountLocaleCleaned, isUserEntered);
}

String getNumberClearedWithMaxSymbol(
    String? amount,
    { String? lang,
      bool isUserEntered = false,
      bool isPhoneNumber = false,
      int maxSize = 10}) {
  String amountLocaleCleaned = _clearNumberForLocale(amount, lang, isUserEntered, isPhoneNumber);
  return _clearNumberMaxSymbols(amountLocaleCleaned, isUserEntered, maxSize: maxSize, needClearMax: true);
}

String _clearNumberForLocale(
    String? amount,
    String? lang,
    bool isUserEntered,
    bool isPhoneNumber) {

  RegExp? regex;

  if (lang == "en") {
    regex = RegExp(Regex.numberCleanEn);
  } else {
    regex = RegExp(Regex.numberCleanRu);
  }

  if (isPhoneNumber) {
    if (amount?.startsWith('7 ') == true) {
      amount = amount?.replaceAll('+7', '').replaceFirst('7 ', '');

    } else if (amount?.startsWith('8') == true
            || amount?.contains('+7') == true
    ) {
      amount = amount?.replaceAll('+7', '').replaceFirst('8', '');
    }
  }

  var amountLocaleCleaned = amount?.replaceAll(regex, '').replaceAll(',', '.') ?? '0';

  var comas = amountLocaleCleaned.split('.');

  if (comas.length > 2) {
    try {
      amountLocaleCleaned = '${comas[0]}.${comas[1] == '' ? comas[2] : comas[1]}';
    } catch (e, m) {
      developer.log('clearNumberForLocale error: $e; $m');
    }
  }

  if (!isUserEntered && amount?.startsWith("-") == true) {
    amountLocaleCleaned = "-$amountLocaleCleaned";
  }

  if (isUserEntered) {
    amountLocaleCleaned = amountLocaleCleaned.replaceAll('.', '');
  }

  return amountLocaleCleaned;
}

String _clearNumberMaxSymbols(String amountLocaleCleaned, bool isUserEntered, {int maxSize = 10, bool needClearMax = false}) {
  var amountSplited = amountLocaleCleaned.split(".");

  if (needClearMax && amountSplited[0].length > maxSize) {
    return amountSplited[0].substring(0, maxSize);

  } else if (amountSplited.length > 1) {
    return _clearDecimalMaxSymbols(amountSplited);

  } else if (isUserEntered && amountSplited.length > 1) {
    return '${amountSplited[0]}.${amountSplited[1]}';

  } else {
    return amountSplited[0];
  }
}

String _clearDecimalMaxSymbols(List<String> amountSplited) {
  var decimal = amountSplited[1];
  if (decimal.length > 2) {
    decimal = amountSplited[1].substring(0, 2);
  }

  return '${amountSplited[0]}.$decimal';
}
