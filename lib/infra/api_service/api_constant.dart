import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiConstant {
  var baseUrl = "your-api-url";


  var tag = 'api_provider';

  handleException(error, stacktrace, DioException dioError) {
    debugPrint("Exception occurred: $error stackTrace: $stacktrace");
    if (_checkSocketException(dioError)) {
      throwIfNoSuccess('no_internet_connection');
    } else if (dioError.response!.statusCode == 400) {
      //throwIfNoSuccess("invalid_request".tr);
      throwIfNoSuccess(dioError.response!.data['message']);
    } else if (dioError.response!.statusCode == 500) {
      throwIfNoSuccess("server_error");
    } else {
      if (dioError.response!.data == null) {
        throwIfNoSuccess("something_went_wrong");
      } else {
        throwIfNoSuccess(dioError.response!.data['message']);
      }
    }
  }
}

void throwIfNoSuccess(String response) {
  throw HttpException(response);
}

bool _checkSocketException(DioException err) {
  return err.type == DioExceptionType.unknown &&
      err.error != null &&
      err.error is SocketException;
}
