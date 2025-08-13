

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiConstant {
  var baseUrl ="use your";







//chat constant
  var checkUser = "/register/check_user";
  var addNewUser = "/register/add_new_user";
  var createRoom = "/register/create-room";
  var getClients = "/get_clients";
  var getChat = "/get_chat";
  var sendNewMessage = "/send_new_msg";

//pusher api constant
  var  userTyping = "/user_typing";
  var msgRead = "/msg_read";
  var onlineUser = "/online_user";
  var changeCaseManager = "/change_case_manager";
  var reportUser ="/report_user";
  var getUnreadMsg = "/get_unread_msg";








  var tag = 'api_provider';

  handleException(error, stacktrace, DioError dioError) {
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

bool _checkSocketException(DioError err) {
  return err.type == DioErrorType.unknown && err.error != null && err.error is SocketException;
}
