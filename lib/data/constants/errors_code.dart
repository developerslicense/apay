import 'package:apay/data/constants/routes.dart';
import 'package:apay/data/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../airba_pay_sdk.dart';
import '../data_holder.dart';
import '../utils/exit_utils.dart';
import '../utils/navigate_utils.dart';

enum ErrorsCode {
  error_1(1, '', '', '', '', '', '', '', ''),
  error_5002(
      5002,
      'Неверный номер карты',
      'Карта нөміріндегі қате',
      tryPayAnotherCardRu,
      tryPayAnotherCardKz,
      payAnotherCardRu,
      payAnotherCardKz,
      goToMarketRu,
      goToMarketKz
  ),
  error_5003(
    5003,
    'Истек срок карты',
    'Картаның мерзімі бітті',
    tryPayAnotherCardRu,
    tryPayAnotherCardKz,
    payAnotherCardRu,
    payAnotherCardKz,
    goToMarketRu,
    goToMarketKz
  ),
  error_5006(
    5006,
    'Неверный CVV',
    'CVV қатесі',
    tryPayAnotherCardRu,
    tryPayAnotherCardKz,
    payAnotherCardRu,
    payAnotherCardKz,
    goToMarketRu,
    goToMarketKz
  ),
  error_5007(
    5007,
    'Недостаточно средств',
    'Қаражат жеткіліксіз',
    'Попробуйте снова или оплатите другой картой',
    'Қайталап көріңіз немесе басқа картамен төлеңіз',
    tryAgainRu,
    tryAgainKz,
    goToMarketRu,
    goToMarketKz
  ),
  error_5008(
    5008,
    limitExceededRu,
    limitExceededKz,
    'Попробуйте оплатить другой картой или измените лимит в настройках банкинга',
    'Басқа картамен төлеуге тырысыңыз немесе банк параметрлерінде лимитті өзгертіңіз',
    tryAgainRu,
    tryAgainKz,
    payAnotherCardRu,
    payAnotherCardKz
  ),
  error_5009(
    5009,
    'Неверно введен код 3ds',
    '3ds коды қате енгізілді',
    'Попробуйте повторно ввести код 3Ds',
    '3D кодын қайта енгізіп көріңіз',
    tryAgainRu,
    tryAgainKz,
    goToMarketRu,
    goToMarketKz
  ),
  error_5020(5020, '', '', '', '', '', '', '', ''),
  error_5999(
    5999,
    limitExceededRu,
    limitExceededKz,
    'Измените лимит в настройках банкинга и попробуйте снова.\nЛибо оплатите другой картой',
    'Банк параметрлерінде шектеуді өзгертіп, әрекетті қайталаңыз.\nНемесе басқа картамен төлеңіз',
    tryAgainRu,
    tryAgainKz,
    payAnotherCardRu,
    payAnotherCardKz
  );

  const ErrorsCode(
      this.code,
      this.messageRu,
      this.messageKz,
      this.descriptionRu,
      this.descriptionKz,
      this.buttonTopRu,
      this.buttonTopKz,
      this.buttonBottomRu,
      this.buttonBottomKz,);

  factory ErrorsCode.initByCode(int code) {
    switch (code) {
      case 5002: return error_5002;
      case 5003: return error_5003;
      case 5006: return error_5006;
      case 5007: return error_5007;
      case 5008: return error_5008;
      case 5009: return error_5009;
      case 5999: return ErrorsCode.error_5999;
      default: return error_1;
    }
  }

  final int code;

  final String messageRu;
  final String messageKz;
  final String descriptionRu;
  final String descriptionKz;
  final String buttonTopRu;
  final String buttonTopKz;
  final String buttonBottomRu;
  final String buttonBottomKz;

  String message() {
    if (DataHolder.currentLang == AirbaPaySdkLang.kz.lang) {
      return messageKz;
    } else {
      return messageRu;
    }
  }

  String description() {
    if (DataHolder.currentLang == AirbaPaySdkLang.kz.lang) {
      return descriptionKz;
    } else {
      return descriptionRu;
    }
  }

  String buttonTop() {
    if (DataHolder.currentLang == AirbaPaySdkLang.kz.lang) {
      return buttonTopKz;
    } else {
      return buttonTopRu;
    }
  }

  String buttonBottom() {
    if (DataHolder.currentLang == AirbaPaySdkLang.kz.lang) {
      return buttonBottomKz;
    } else {
      return buttonBottomRu;
    }
  }

  void clickOnTop(BuildContext context) {
    switch (code) {
      case 5002: { backHome(context); }
      case 5003: { backHome(context); }
      case 5006: { backHome(context); }
      case 5007: { openRepeat(context); }
      case 5008: { openRepeat(context); }
      case 5009: { openRepeat(context); }
      case 5999: { openRepeat(context); }
      default: { exitSdk(context); }
    }
  }

  void clickOnBottom(BuildContext context) {
    switch (code) {
      case 5008: { backHome(context); }
      case 5999: { backHome(context); }
      default: { exitSdk(context); }

    }
  }
}
