import 'package:dio/dio.dart';

import '../data_holder.dart';
import '../models/base_network_response.dart';
import '../utils/logger.dart';

enum RequestType {
  GET, POST, PUT, PATCH, DELETE
}

// https://sps.airbapay.kz/acquiring-api/sdk/swagger/index.html#/

class Api {

  final dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: DataHolder.baseUrl,
      receiveTimeout: Duration(seconds: DataHolder.receiveTimeout),
      connectTimeout: Duration(seconds: DataHolder.connectTimeout),
      sendTimeout: Duration(seconds: DataHolder.sendTimeout),
    ));

    /*dio.interceptors.addAll({
      AuthInterceptor(dio),
    });*/
    if (!DataHolder.isProd) {
      dio.interceptors.addAll({
        Logging(dio),
      });
    }

    return dio;
  }

  Future<NetworkResponse?> apiCall({
      required String url,
      Map<String, dynamic>? params,
      String? accessToken,
      required RequestType requestType}) async {

    late Response result;
    Options? options = Options(
        headers: {'Authorization': accessToken != null ? 'Bearer $accessToken' : ''}
    );

    try {
      switch (requestType) {
        case RequestType.GET: {
          result = await dio.get(url, queryParameters: params, options: options);
          break;
        }
        case RequestType.POST: {
          result = await dio.post(url, data: params, options: options);
          break;
        }
        case RequestType.DELETE: {
          result = await dio.delete(url, data: params, options: options);
          break;
        }
        case RequestType.PUT: {
          result = await dio.put(url, data: params, options: options);
          break;
        }
        case RequestType.PATCH: {
          result = await dio.patch(url, data: params, options: options);
          break;
        }
      }

      if(result.data != null) {
        LoggerAirba.log('NetworkResponse.success:');
        return NetworkResponse.success(result.data);

      } else {
        LoggerAirba.log('NetworkResponse.error: Data is null');
        return NetworkResponse.error("Data is null");
      }

    } on DioException catch (error) {
      LoggerAirba.errorLog(error);
      return NetworkResponse.error(error.message ?? '');

    } catch (error) {
      LoggerAirba.log('NetworkResponse.error: ${error.toString()}');
      return NetworkResponse.error(error.toString());
    }
  }

}

class ErrorInterceptors extends Interceptor {
  final Dio dio;

  ErrorInterceptors(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeOutException(err.requestOptions);

      case DioExceptionType.cancel:
        break;
      default: {

          if (err.response != null) {
            switch (err.response?.statusCode) {
              case 400:
              throw BadRequestException(err.requestOptions);
              case 401:
              throw UnauthorizedException(err.requestOptions);
              case 404:
              throw NotFoundException(err.requestOptions);
              case 409:
              throw ConflictException(err.requestOptions);
              case 500:
              throw InternalServerErrorException(err.requestOptions);
            }

          } else {
            throw NoInternetConnectionException(err.requestOptions);
          }
        }
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class TimeOutException extends DioException {
  TimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class Logging extends Interceptor {
  final Dio dio;
  Logging(this.dio);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerAirba.log('REQUEST => ${options.method} ${options.uri}');
    LoggerAirba.log('DATA: ${options.data}');
    LoggerAirba.log('QueryParameters: ${options.queryParameters}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LoggerAirba.log('RESPONSE[${response.statusCode}] => ${response.requestOptions.method} ${response.requestOptions.uri}');
    LoggerAirba.log('DATA: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerAirba.log(
      'ERROR[${err.response?.statusCode}] => ${err.requestOptions.method}  ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}

/*class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await TokenRepository().getAccessToken();

    if (accessToken != null) {
      var expiration = await TokenRepository().getAccessTokenRemainingTime();

      if (expiration.inSeconds < 60) {
        dio.interceptors.requestLock.lock();

        // Call the refresh endpoint to get a new token
        await UserService()
            .refresh()
            .then((response) async {
          await TokenRepository().persistAccessToken(response.accessToken);
          accessToken = response.accessToken;
        }).catchError((error, stackTrace) {
          handler.reject(error, true);
        }).whenComplete(() => dio.interceptors.requestLock.unlock());
      }

      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
}*/