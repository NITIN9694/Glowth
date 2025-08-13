
import 'package:dio/dio.dart';

import 'log.dart';

void logWithColor(String message, {String color = '\x1B[32m'}) {
  final reset = '\x1B[0m'; // Reset color
  print('$color$message$reset');
}

class DioLogger{

  static void onSend(String tag, RequestOptions options){
    print('onsend called');
    Log.info('$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}');
    Log.info('$tag - Request Headers : [${options.headers}]');
    Log.info('$tag - Request Data : ${options.queryParameters.toString()}');
    Log.info('$tag - Request Data : ${options.data.toString()}');
  }
  static void onSuccess(String tag, Response response){
    logWithColor('$tag - Response Path : [${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path} Request Data : ${response.requestOptions.data.toString()}',color: '\x1B[36m');
    logWithColor('$tag - Response statusCode : ${response.statusCode}',color: '\x1B[36m');
    logWithColor('$tag - Response data : ${response.data.toString()}',color: '\x1B[36m');
  }
  static void onError(String tag, DioError error){
    if(null != error.response){
      logWithColor('$tag - Error Path : [${error.requestOptions.method}] ${error.requestOptions.baseUrl}${error.requestOptions.path} Request Data : ${error.requestOptions.data.toString()}', color: '\x1B[31m');
      logWithColor('$tag - Error data : ${null != error.requestOptions.data ? error.requestOptions.data.toString() : ''}', color: '\x1B[31m');
    }
    logWithColor('$tag - Error Message : ${error.message}', color: '\x1B[31m');
  }
}