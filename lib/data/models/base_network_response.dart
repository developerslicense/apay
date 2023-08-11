class NetworkResponse {
  Map<String, dynamic>? data;
  List<dynamic>? dataList;

  NetworkResponse({
    this.data,
    this.dataList,
    String? errorMessage });

  factory NetworkResponse.success(Map<String, dynamic> data) {
    return NetworkResponse(data: data);
  }

  factory NetworkResponse.successList(List<dynamic> data) {
    return NetworkResponse(dataList: data);
  }

  factory NetworkResponse.error(String message) {
    return NetworkResponse(errorMessage: message);
  }

}

