import '../utils/card_utils/card_type.dart';
import 'base_network_response.dart';

class CardAddResponse extends NetworkResponse {
  String? cardId() => data?['id'];

  CardAddResponse(NetworkResponse? response) {
    data = response?.data;
  }
}

class CardsGetResponse extends NetworkResponse {
  List<BankCard> getCards() {
    List<BankCard> cards = [];

    for (var element in dataList ?? []) {
      cards.add(BankCard.fromJson(element));
    }

    return cards;
  }

  CardsGetResponse(NetworkResponse? response) {
    dataList = response?.dataList;
  }
}

class BankCard { // используется для всех случаев. но в разных случаях и разные поля могут отсутствовать
  String? pan;
  String? accountId;
  String? maskedPan;
  String? expire;
  String? name;
  String? id;
  String? type;
  String? issuer;

  BankCard({
    this.pan,
    this.expire,
    this.name,
    this.issuer,
    this.id,
    this.accountId,
    this.type,
    this.maskedPan
  });

  factory BankCard.fromJson(dynamic json) => BankCard(
      pan: json['pan'] ?? '',
      expire: json['expire'] ?? '',
      name: json['name'] ?? '',
      issuer: json['issuer'] ?? '',
      accountId: json['account_id'] ?? '',
      maskedPan: json['masked_pan'] ?? '',
      id: json['id'] ?? '',
      type: json['type'] ?? '',
  );

  String getMaskedPanCleared() {
    try {
      return maskedPan?.substring((maskedPan?.length ?? 0) - 6) ?? '';
    } catch (e) {
      return '';
    }
  }

  String getTypeIcon() {
    switch (type) {
      case "VISA": return CardType.visa.icon;
      case "MC": return CardType.masterCard.icon;
      case "AE": return CardType.americanExpress.icon;
      default: return CardType.maestro.icon;
    }
  }
}