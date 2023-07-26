import 'package:apay/data/models/base_network_response.dart';
import 'package:apay/data/utils/base_strings.dart';
import 'package:apay/data/utils/logger.dart';
import 'package:dio/dio.dart';

import '../../data_holder.dart';
import '../../models/card.dart';
import '../../models/payments_request.dart';
import '../../models/payments_response.dart';
import '../api.dart';

// https://sps.airbapay.kz/acquiring-api/sdk/swagger/index.html#/

Future<PaymentCreateResponse?> createPayment({
  required String amount,
  required String orderNumber,
  required String invoiceId,
  required String? cardId, //todo откуда взять???
  required String? accessToken,
  required bool saveCard,
  required List<Goods> goods,
  List<SettlementPayment>? settlementPayments

}) async {
  Api api = Api();

  try {
    var mappedSettlementPayments = [];
    var mappedGoods = [];

    if (settlementPayments != null) {
      for (var element in settlementPayments) {
        mappedSettlementPayments.add({
          "amount": element.amount?.toDouble(),
          "company_id": element.companyId
        });
      }
    }

    for (var element in goods) {
      mappedGoods.add(element.toMap());
    }

    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments',
      accessToken: accessToken,
      requestType: RequestType.POST,
      params: {
        "account_id": DataHolder.userPhone,
        "amount": double.parse(amount),
        "auto_charge": 0,
        "card_id": cardId,
        "card_save": saveCard,
        "cart": {
          "goods": mappedGoods
        },
        "currency": "KZT",
        "description": "Description",
        "email": DataHolder.userEmail,
        "failure_back_url": DataHolder.failureBackUrl,
        "failure_callback": DataHolder.failureCallback,
        "invoice_id": invoiceId,
        "language": StringsBase.currentLang,
        "order_number": orderNumber,
        "phone": DataHolder.userPhone,
        if (mappedSettlementPayments.isNotEmpty) "settlement": { //не обязательный параметр, нужно присылать, если есть необходимость в разделении счетов по компаниям
          "payments": mappedSettlementPayments
        },
        "success_back_url": DataHolder.successBackUrl,
        "success_callback": DataHolder.successCallback
      },
    );
    return PaymentCreateResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}

Future<PaymentInfoResponse?> getPaymentInfo({
  required String? accessToken
}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments',
      accessToken: accessToken,
      requestType: RequestType.GET
    );
    return PaymentInfoResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}

Future<PaymentEntryResponse?> paymentAccountEntry({ //проводка платежа
  required String? accessToken,
  required bool saveCard,
  required bool sendReceipt,
  required BankCard card,
  required String? cvv,
}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments',
      accessToken: accessToken,
      requestType: RequestType.PUT,
      params: {
        "card": {
          "card_name": card.name,
          "cvv": cvv,
          "expiry": card.expire,
          "id": card.id,
          "pan": card.pan
        },
        "card_save": saveCard,
        "email": DataHolder.userEmail,
        "send_receipt": sendReceipt
      }
    );
    return PaymentEntryResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}

Future<PaymentEntryResponse?> paymentAccountEntryRetry({// проводка платежа без ввода данных карты
  required String? accessToken
}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments/retry',
      accessToken: accessToken,
      requestType: RequestType.PUT
    );
    return PaymentEntryResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}
