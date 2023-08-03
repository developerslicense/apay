import '../../airba_pay_sdk.dart';
import 'string_utils.dart';

Goods initGoodsFromString(String arguments) {
  var splitted = arguments.split('?');

  return Goods(
      brand: getValueFromArguments(splitted, 'good_brand'),
      category: getValueFromArguments(splitted, 'good_category'),
      model: getValueFromArguments(splitted, ''),
      price: int.parse(getValueFromArguments(splitted, 'good_price') ?? '0'),
      quantity: int.parse(getValueFromArguments(splitted, 'good_quantity') ?? '0'));
}

