import 'package:apay/data/constants/routes.dart';
import 'package:apay/data/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../airba_pay_sdk.dart';
import '../data_holder.dart';
import '../utils/exit_utils.dart';

enum ErrorsCode {
  error_1(1, '', '', '', '', '', '', '', ''),
  error_5002(
      5002,
      'Неверный номер карты',
      'Карта нөміріндегі қате',
      'Попробуйте оплатить другой картой',
      'Басқа картамен төлеуге тырысыңыз',
      'Оплатить другой картой',
      'Басқа картамен төлеңіз',
      'Вернуться в магазин',
      'Дүкенге оралу'
  ),
  error_5003(
    5003,
    'Истек срок карты',
    'Картаның мерзімі бітті',
    'Попробуйте оплатить другой картой',
    'Басқа картамен төлеуге тырысыңыз',
    'Оплатить другой картой',
    'Басқа картамен төлеңіз',
    'Вернуться в магазин',
    'Дүкенге оралу'
  ),
  error_5006(
    5006,
    'Неверный CVV',
    'CVV қатесі',
    'Попробуйте оплатить другой картой',
    'Басқа картамен төлеуге тырысыңыз',
    'Оплатить другой картой',
    'Басқа картамен төлеңіз',
    'Вернуться в магазин',
    'Дүкенге оралу'
  ),
  error_5007(
    5007,
    'Недостаточно средств',
    'Қаражат жеткіліксіз',
    'Попробуйте снова или оплатите другой картой',
    'Қайталап көріңіз немесе басқа картамен төлеңіз',
    tryAgainRu,
    tryAgainKz,
    'Вернуться в магазин',
    'Дүкенге оралу'
  ),
  error_5008(
    5008,
    'Превышен лимит \nпо карте',
    'Карта шегінен \nасып кетті',
    'Попробуйте оплатить другой картой или измените лимит в настройках банкинга',
    'Басқа картамен төлеуге тырысыңыз немесе банк параметрлерінде лимитті өзгертіңіз',
    tryAgainRu,
    tryAgainKz,
    'Оплатить другой картой',
    'Басқа картамен төлеңіз'
  ),
  error_5009(
    5009,
    'Неверно введен код 3ds',
    '3ds коды қате енгізілді',
    'Попробуйте повторно ввести код 3Ds',
    '3D кодын қайта енгізіп көріңіз',
    tryAgainRu,
    tryAgainKz,
    'Вернуться в магазин',
    'Дүкенге оралу'
  ),
  error_5020(5020, '', '', '', '', '', '', '', ''),
  error_5999(
    5999,
    'Превышен лимит \nпо карте',
    'Карта шегінен \nасып кетті',
    'Попробуйте оплатить другой картой или измените лимит в настройках банкинга',
    'Басқа картамен төлеуге тырысыңыз немесе банк параметрлерінде лимитті өзгертіңіз',
    tryAgainRu,
    tryAgainKz,
    'Оплатить другой картой',
    'Басқа картамен төлеңіз'
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
      case 5002: { Navigator.of(context).popUntil((route) => route.isFirst); }
      case 5003: { Navigator.of(context).popUntil((route) => route.isFirst); }
      case 5006: { Navigator.of(context).popUntil((route) => route.isFirst); }
      case 5007: { Navigator.pushNamed(context, routesRepeat); }
      case 5008: { Navigator.pushNamed(context, routesRepeat); }
      case 5009: { Navigator.pushNamed(context, routesRepeat); }
      case 5999: { Navigator.pushNamed(context, routesRepeat); }
      default: { exitSdk(); }
    }
  }

  void clickOnBottom(BuildContext context) {
    switch (code) {
      case 5008: { Navigator.of(context).popUntil((route) => route.isFirst); }
      case 5999: { Navigator.of(context).popUntil((route) => route.isFirst); }
      default: { exitSdk(); }

    }
  }
}
