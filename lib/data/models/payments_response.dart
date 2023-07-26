import 'package:apay/data/models/base_network_response.dart';

import 'card.dart';

class PaymentCreateResponse extends NetworkResponse {
  String? id() => data?['id'];
  String? invoiceId() => data?['invoice_id'];

  PaymentCreateResponse(NetworkResponse? response) {
    data = response?.data;
  }
}

class PaymentInfoResponse extends NetworkResponse {
  Secure3D? secure3D() => Secure3D(data?['secure3D']);
  BankCard? card() => BankCard.fromJson(data?['card']);

  bool cardSave() => data?['card_save'];
  bool isRetry() => data?['is_retry'];
  int? amount() => data?['amount'];
  int? errorCode() => data?['error_code'];
  String? bankCode() => data?['bank_code'];
  String? cardId() => data?['card_id'];
  String? created() => data?['created'];
  String? currency() => data?['currency'];
  String? description() => data?['description'];
  String? email() => data?['email'];
  String? errorMessage() => data?['error_message'];
  String? expired() => data?['expired'];
  String? failureBackUrl() => data?['failure_back_url'];
  String? id() => data?['id'];
  String? invoiceId() => data?['invoice_id'];
  String? language() => data?['language'];
  String? orderNumber() => data?['order_number'];
  String? phone() => data?['phone'];
  String? successBackUrl() => data?['success_back_url'];
  String? status() => data?['status'];
  String? terminalId() => data?['terminal_id'];
  String? type() => data?['type'];

  PaymentInfoResponse(NetworkResponse? response) {
    data = response?.data;
  }
}

class Secure3D {
  String? action;
  String? md;
  String? paReq;
  String? termUrl;

  Secure3D(Map<String, dynamic> json) {
    action = json['action'];
    md = json['md'];
    paReq = json['pa_req'];
    termUrl = json['term_url'];
  }
}

class PaymentEntryResponse extends NetworkResponse {
  Secure3D? secure3D() => Secure3D(data?['secure3D']);

  int? errorCode() => data?['error_code'];
  String? errorMessage() => data?['error_message'];
  bool isSecure3D() => data?['is_secure3D'];
  bool isRetry() => data?['is_retry'];// если true, то можно через кнопку "повторить"


  PaymentEntryResponse(NetworkResponse? response) {
    data = response?.data;
  }
}


