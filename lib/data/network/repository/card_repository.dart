import 'package:apay/data/models/card.dart';
import 'package:dio/dio.dart';

import '../../data_holder.dart';
import '../../models/base_network_response.dart';
import '../../utils/logger.dart';
import '../api.dart';

// https://sps.airbapay.kz/acquiring-api/sdk/swagger/index.html#/

Future<CardAddResponse?> cardAdd({
  required String? accessToken

}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/cards',
      accessToken: accessToken,
      requestType: RequestType.POST,
      params: {
        'language': DataHolder.currentLang,
        'account_id': DataHolder.userPhone,
        'email': DataHolder.userEmail,
        'phone': DataHolder.userPhone,
        'failure_back_url': DataHolder.failureBackUrl,
        'failure_callback': DataHolder.failureCallback,
        'success_back_url': DataHolder.successBackUrl,
        'success_callback': DataHolder.successCallback
      },
    );
    return CardAddResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}

Future<CardsGetResponse?> getCards({
  required String phone,
  required String? accessToken

}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
        url: '/api/v1/cards/$phone',
        requestType: RequestType.GET,
        accessToken: accessToken
    );
    return CardsGetResponse(response);

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}

Future<NetworkResponse?> deleteCard({
  required String cardId,
  required String? accessToken

}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
        url: '/api/v1/cards/$cardId',
        requestType: RequestType.DELETE,
        accessToken: accessToken
    );
    return response;

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}
