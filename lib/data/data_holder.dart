import 'package:apay/airba_pay_sdk.dart';

import 'models/payments_request.dart';

class DataHolder {
  static String baseUrl = '';

  static int connectTimeout = 60;
  static int receiveTimeout = 60;
  static int sendTimeout = 60;

  static bool isProd = true;

  static String? accessToken;
  static String purchaseAmount = '';
  static String orderNumber = '';
  static String invoiceId = '';
  static String shopId = '';
  static String? userEmail;
  static String userPhone = '';
  static String password = '';
  static String terminalId  = '';
  static String failureBackUrl = '';
  static String failureCallback = '';
  static String successBackUrl = '';
  static String successCallback = '';
  static String currentLang = AirbaPaySdkLang.ru.lang;

  static List<Goods>? goods;
}