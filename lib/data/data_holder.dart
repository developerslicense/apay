import 'package:apay/airba_pay_sdk.dart';


class DataHolder {
  static String baseUrl = '';

  static int connectTimeout = 60;
  static int receiveTimeout = 60;
  static int sendTimeout = 60;

  static bool isProd = true;

  static String? bankName;
  static String? accessToken;
  static String? cardId;
  static String purchaseAmount = '';
  static String orderNumber = '';
  static String invoiceId = '';
  static String shopId = '';
  static String? userEmail;
  static String userPhone = '';
  static String password = '';
  static String terminalId  = '';
  static String failureBackUrl = 'https://site.kz/failure';
  static String failureCallback = '';
  static String successBackUrl = 'https://site.kz/success';
  static String successCallback = '';
  static String currentLang = AirbaPaySdkLang.ru.lang;

  static List<Goods>? goods;
  static List<SettlementPayment>? settlementPayments;

  static String purchaseAmountFormatted = '';

  static bool isAuthenticated = false;
}