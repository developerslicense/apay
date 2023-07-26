import 'package:apay/data/models/base_network_response.dart';

class AuthResponse extends NetworkResponse {
  String? getAccessToken() => data?['access_token'];

  AuthResponse(NetworkResponse? response) {
    data = response?.data;
  }
}
