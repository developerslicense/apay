import 'package:apay/data/models/base_network_response.dart';
import 'package:apay/data/utils/logger.dart';
import 'package:dio/dio.dart';

import '../../data_holder.dart';
import '../../models/card.dart';
import '../../models/payments_response.dart';
import '../../utils/number_clearer_utils.dart';
import '../api.dart';

// https://sps.airbapay.kz/acquiring-api/sdk/swagger/index.html#/

Future<PaymentCreateResponse?> createPayment({
  required bool saveCard

}) async {
  Api api = Api();

  try {
    var mappedSettlementPayments = [];
    var mappedGoods = [];

    if (DataHolder.settlementPayments != null) {
      for (var element in DataHolder.settlementPayments!) {
        mappedSettlementPayments.add({
          "amount": element.amount?.toDouble(),
          "company_id": element.companyId
        });
      }
    }

    for (var element in DataHolder.goods ?? []) {
      mappedGoods.add(element.toMap());
    }

    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments',
      accessToken: DataHolder.accessToken,
      requestType: RequestType.POST,
      params: {
        "account_id": DataHolder.userPhone,
        "amount": double.parse(getNumberCleared(DataHolder.purchaseAmount)),
        "auto_charge": 0,
        "card_id": DataHolder.cardId, // todo cardId
        "card_save": saveCard,
        "cart": {
          "goods": mappedGoods
        },
        "currency": "KZT",
        "description": "Description",
        "email": DataHolder.userEmail,
        "failure_back_url": DataHolder.failureBackUrl,
        "failure_callback": DataHolder.failureCallback,
        "invoice_id": DataHolder.invoiceId,
        "language": DataHolder.currentLang,
        "order_number": DataHolder.orderNumber,
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

Future<PaymentInfoResponse?> getPaymentInfo() async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments',
      accessToken: DataHolder.accessToken,
      requestType: RequestType.GET
    );
    return PaymentInfoResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}

Future<PaymentEntryResponse?> paymentAccountEntry({ //проводка платежа
  required bool saveCard,
  required bool sendReceipt,
  required BankCard card,
  required String? cvv,
}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments',
      accessToken: DataHolder.accessToken,
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

Future<PaymentEntryResponse?> paymentAccountEntryRetry(// проводка платежа без ввода данных карты
) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/payments/retry',
      accessToken: DataHolder.accessToken,
      requestType: RequestType.PUT
    );
    return PaymentEntryResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}
