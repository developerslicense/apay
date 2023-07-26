import 'package:apay/data/data_holder.dart';
import 'package:apay/data/models/auth.dart';
import 'package:apay/data/models/base_network_response.dart';
import 'package:apay/data/utils/logger.dart';
import 'package:dio/dio.dart';

import '../api.dart';

// https://sps.airbapay.kz/acquiring-api/sdk/swagger/index.html#/

Future<AuthResponse?> auth({
  required String? paymentId,
  required String user,
  required String password,
  required String terminalId,
  required String? accessToken

}) async {
  Api api = Api();

  try {
    NetworkResponse? response = await api.apiCall(
      url: '/api/v1/auth/sign-in',
      accessToken: accessToken,
      requestType: RequestType.POST,
      params: {
        'password': password,
        'payment_id': paymentId ?? '',
        'terminal_id': terminalId,
        'user': user
      },
    );
    var authResponse = AuthResponse(response);
    DataHolder.accessToken = authResponse.getAccessToken();
    return authResponse;

  } on DioException catch (e) {
    LoggerAirba.errorLog(e);
  }
  return null;
}

