class NetworkResponse {
  Map<String, dynamic>? data;
  // String? errorMessage;

  NetworkResponse({
    this.data,
    String? errorMessage });

  factory NetworkResponse.success(Map<String, dynamic> data) {
    return NetworkResponse(data: data);
  }

  factory NetworkResponse.error(String message) {
    return NetworkResponse(errorMessage: message);
  }

}

