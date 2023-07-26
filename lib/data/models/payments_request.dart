import '../utils/string_utils.dart';

class SettlementPayment {
  int? amount;
  String? companyId;
}

class Goods {
  String? brand;
  String? category;
  String? model;
  int? discount;
  int? quantity;
  int? price;

  Goods({
    this.brand,
    this.quantity,
    this.price,
    this.model,
    this.discount,
    this.category,
});

  factory Goods.initFromString(String arguments) {
    var splitted = arguments.split('?');

    return Goods(
      brand: getValueFromArguments(splitted, 'good_brand'),
      category: getValueFromArguments(splitted, 'good_category'),
      model: getValueFromArguments(splitted, ''),
      price: int.parse(getValueFromArguments(splitted, 'good_price') ?? '0'),
      quantity: int.parse(getValueFromArguments(splitted, 'good_quantity') ?? '0')
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "brand": brand,
      "category": category,
      "discount": discount,
      "model": model,
      "price": price,
      "quantity": quantity
    };
  }
}