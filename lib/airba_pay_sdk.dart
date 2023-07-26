import 'package:apay/data/models/payments_request.dart';

import 'data/data_holder.dart';
import 'data/utils/base_strings.dart';
import 'data/utils/money_utlis.dart';
import 'data/utils/string_utils.dart';

class AirbaPaySdk {

  static void initOnStart(String arguments) {
    var resultArgument = arguments.split('?');
    var resultArgumentProducts = arguments.split('good_model');
    print('resultArguments=$resultArgument');
    print('resultArgumentsProducts=$resultArgumentProducts');

    var isProd = getValueFromArguments(resultArgument, 'isProd');
    var purchaseAmount = getValueFromArguments(resultArgument, 'purchaseAmount') ?? '0';
    var phone = getValueFromArguments(resultArgument, 'phone');
    var orderNumber = getValueFromArguments(resultArgument, 'orderNumber');
    var invoiceId = getValueFromArguments(resultArgument, 'invoiceId');
    var shopId = getValueFromArguments(resultArgument, 'shopId');
    var password = getValueFromArguments(resultArgument, 'password');
    var terminalId = getValueFromArguments(resultArgument, 'terminalId');
    var failureBackUrl = getValueFromArguments(resultArgument, 'failureBackUrl');
    var failureCallback = getValueFromArguments(resultArgument, 'failureCallback');
    var successBackUrl = getValueFromArguments(resultArgument, 'successBackUrl');
    var successCallback = getValueFromArguments(resultArgument, 'successCallback');
    var userEmail = getValueFromArguments(resultArgument, 'userEmail');

    var goods = [];
    for (var i = 1; i < resultArgumentProducts.length; i++) {
      goods.add(Goods.initFromString(resultArgumentProducts[i]));
    }

    _initProcessing(
        isProd: isProd == 'true' ? true : false,
        purchaseAmount: int.parse(purchaseAmount),
        phone: phone ?? '',
        orderNumber: orderNumber ?? '',
        invoiceId: invoiceId ?? '',
        shopId: shopId ?? '',
        password: password ?? '',
        terminalId: terminalId ?? '',
        failureBackUrl: failureBackUrl ?? '',
        failureCallback: failureCallback ?? '',
        successBackUrl: successBackUrl ?? '',
        successCallback: successCallback ?? '',
        goods: List<Goods>.from(goods),
        userEmail: userEmail,
        connectTimeout: 60,
        receiveTimeout: 60,
        sendTimeout: 60);
  }

  static void _initProcessing({
    required bool isProd,
    required int purchaseAmount,
    required String phone,
    required String orderNumber,
    required String invoiceId,
    required String shopId,
    required String password,
    required String terminalId,
    required String failureBackUrl,
    required String failureCallback,
    required String successBackUrl,
    required String successCallback,
    required List<Goods> goods,
    String? userEmail,
    int connectTimeout = 60,
    int receiveTimeout = 60,
    int sendTimeout = 60,
    String lang = 'ru'
  }) {
    DataHolder.accessToken = null;
    DataHolder.isProd = isProd;
    DataHolder.baseUrl = isProd ? 'https://ps.airbapay.kz/acquiring-api/sdk' : 'https://sps.airbapay.kz/acquiring-api/sdk';

    DataHolder.userPhone = phone;
    DataHolder.userEmail = userEmail;

    DataHolder.failureBackUrl = failureBackUrl;
    DataHolder.failureCallback = failureCallback;
    DataHolder.successBackUrl = successBackUrl;
    DataHolder.successCallback = successCallback;

    DataHolder.sendTimeout = sendTimeout;
    DataHolder.connectTimeout = connectTimeout;
    DataHolder.receiveTimeout = receiveTimeout;
    DataHolder.shopId = shopId;
    DataHolder.password = password;
    DataHolder.terminalId = terminalId;
    DataHolder.purchaseAmount = Money(purchaseAmount).getFormatted();
    DataHolder.orderNumber = orderNumber;
    DataHolder.invoiceId = invoiceId;

    DataHolder.goods = goods;

    StringsBase.currentLang = lang;
  }

  // Эта функция нужна только для тестирования во время доработки библиотеки
  static String getStringArgumentForInitProcessingTest() {
    var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    return 'isProd=false' +
        '?' +
        'purchaseAmount=50150' +
        '?' +
        'phone=77051234567' +
        '?' +
        'invoiceId=$timeStamp' +
        '?' +
        'orderNumber=$timeStamp' +
        '?' +
        'shopId=test-merchant' +
        '?' +
        'password=123456' +
        '?' +
        'terminalId=64216e7ccc4a48db060dd689' +
        '?' +
        'failureBackUrl=https://site.kz/failure' +
        '?' +
        'failureCallback=https://site.kz/failure-clb' +
        '?' +
        'successBackUrl=https://site.kz/success' +
        '?' +
        'successCallback=https://site.kz/success-clb' +
        '?' +
        'userEmail=test@test.com' +
        '?' +
        'good_model=Чай Tess Banana Split черный 20 пирамидок' +
        '?' +
        'good_quantity=1' +
        '?' +
        'good_brand=Tess' +
        '?' +
        'good_price=1000' +
        '?' +
        'good_category=Черный чай' +
        '?' +
        'good_model=Чай Standard' +
        '?' +
        'good_quantity=2' +
        '?' +
        'good_brand=Greenfild' +
        '?' +
        'good_price=2000' +
        '?' +
        'good_category=Зеленый чай' +
        '?';
  }

}
