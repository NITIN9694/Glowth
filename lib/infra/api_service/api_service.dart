

import 'package:dio/dio.dart';
import 'api_constant.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = ApiConstant().baseUrl;
  var apiEndPoints = ApiConstant();
  DioError? _dioError;


  ApiService(String token) {
    _dio.options.baseUrl = _baseUrl;

    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

  }

  void updateToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }




// Add more methods for GET, PUT, DELETE, etc. if needed.
}

