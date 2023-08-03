import 'package:apay/data/utils/init_goods_from_string.dart';
import 'package:apay/data/utils/string_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void testParsing() {
  test('test parsing', () {
    var arguments = _initArguments();
    var resultArgument = arguments.split('?');
    var resultArgumentProducts = arguments.split('good_model');

    expect(_getValue(resultArgument, 'isProd'), 'false');
    expect(_getValue(resultArgument, 'purchaseAmount'), '50150');
    expect(_getValue(resultArgument, 'phone'), '77051234567');
    expect(_getValue(resultArgument, 'orderNumber'), '123');
    expect(_getValue(resultArgument, 'invoiceId'), '123');
    expect(_getValue(resultArgument, 'shopId'), 'test-merchant');
    expect(_getValue(resultArgument, 'password'), '123456');
    expect(_getValue(resultArgument, 'terminalId'), '64216e7ccc4a48db060dd689');
    expect(_getValue(resultArgument, 'failureBackUrl'), 'https://site.kz/failure');
    expect(_getValue(resultArgument, 'failureCallback'), 'https://site.kz/failure-clb');
    expect(_getValue(resultArgument, 'successBackUrl'), 'https://site.kz/success');
    expect(_getValue(resultArgument, 'successCallback'), 'https://site.kz/success-clb');
    expect(_getValue(resultArgument, 'userEmail'), 'test@test.com');

    expect(
        resultArgumentProducts[0],
        'isProd=false?' +
            'purchaseAmount=50150?' +
            'phone=77051234567?' +
            'invoiceId=123?' +
            'orderNumber=123?' +
            'shopId=test-merchant?' +
            'password=123456?' +
            'terminalId=64216e7ccc4a48db060dd689?' +
            'failureBackUrl=https://site.kz/failure?' +
            'failureCallback=https://site.kz/failure-clb?' +
            'successBackUrl=https://site.kz/success?' +
            'successCallback=https://site.kz/success-clb?' +
            'userEmail=test@test.com?');

    expect(
        resultArgumentProducts[1],
        '=Чай Tess Banana Split черный 20 пирамидок?good_quantity=1?good_brand=Tess?good_price=1000?good_category=Черный чай?');

    expect(
        resultArgumentProducts[2],
        '=Чай Standard?good_quantity=2?good_brand=Greenfild?good_price=2000?good_category=Зеленый чай?');

    var good1 = initGoodsFromString(resultArgumentProducts[1]);
    var good2 = initGoodsFromString(resultArgumentProducts[2]);

    expect(good1.category, 'Черный чай');
    expect(good1.model, 'Чай Tess Banana Split черный 20 пирамидок');
    expect(good1.price, 1000);
    expect(good1.quantity, 1);
    expect(good1.brand, 'Tess');

    expect(good2.category, 'Зеленый чай');
    expect(good2.model, 'Чай Standard');
    expect(good2.price, 2000);
    expect(good2.quantity, 2);
    expect(good2.brand, 'Greenfild');
  });
}

String? _getValue(List<String> resultArgument, String key) {
  return getValueFromArguments(resultArgument, key);
}

String _initArguments() {
  return 'isProd=false' +
      '?' +
      'purchaseAmount=50150' +
      '?' +
      'phone=77051234567' +
      '?' +
      'invoiceId=123' +
      '?' +
      'orderNumber=123' +
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
