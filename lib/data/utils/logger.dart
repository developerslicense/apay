import 'package:dio/dio.dart';
import 'package:simple_logger/simple_logger.dart';

class LoggerAirba {
  static final logger = SimpleLogger();

  static void errorLog(DioException e) {
    if (e.response != null) {
      log('response error:');
      log('STATUS: ${e.response?.statusCode}');
      log('DATA: ${e.response?.data}');
      log('HEADERS: ${e.response?.headers}');
    } else {
      // Error due to setting up or sending the request
      log('Error sending request!');
      log('error message: ${e.message}');
      log('error object: ${e.error}');
      log('error stackTrace: ${e.stackTrace}');
    }
  }

  static void log(String text) {
    logger.levelPrefixes = {};
/*    logger.setLevel(// для внутренней отладки
      Level.INFO,
      includeCallerInfo: true,
    );*/
    logger.info('TagAirbaPay: $text');
  }
}