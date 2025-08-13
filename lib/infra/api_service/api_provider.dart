

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'api_constant.dart';
import 'dio_logger.dart';

class ApiProvider {
  Dio _dio = Dio();

  var apiEndPoints = ApiConstant();
  DioException? _dioError;

  ApiProvider.base() {
    BaseOptions dioOptions = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15)
    )..baseUrl = ApiConstant().baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
          options.headers = {'Content-Type': 'application/json'};
          DioLogger.onSend(ApiConstant().tag, options);
          return handler.next(options);
        }, onResponse: (Response response, handler) {
          DioLogger.onSuccess(ApiConstant().tag, response);
          return handler.next(response);
        }, onError: (DioException error, handler) {
          _dioError = error;
          DioLogger.onError(ApiConstant().tag, error);
          return handler.next(error);
        }));
  }

  ApiProvider.baseWithToken() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = ApiConstant().baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
          // String accessToken =
          // HiveManager.getString(AppConstants.accessToken);

          options.headers = {'Content-Type': 'application/json'};
          // options.headers = {'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImExODE4ZjQ0ODk0MjI1ZjQ2MWQyMmI1NjA4NDcyMDM3MTc2MGY1OWIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQmlqb3kgSGFsZGFyIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0lUZDdsbVd1OHo1LWExMzBJMVNJVmhXWjR1VXluaC1TZEg3M1NUS1BFbXpKMks9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vb25kYy11aSIsImF1ZCI6Im9uZGMtdWkiLCJhdXRoX3RpbWUiOjE3MDg5NDg1NjEsInVzZXJfaWQiOiJjUUNWSzJQYTdaTVFpdFhWZlhHOFIwbXhFY3oxIiwic3ViIjoiY1FDVksyUGE3Wk1RaXRYVmZYRzhSMG14RWN6MSIsImlhdCI6MTcwODk0ODU2MSwiZXhwIjoxNzA4OTUyMTYxLCJlbWFpbCI6ImJpam95LmhhbGRhcjk5OUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNjE4MTM4NzM1NDk3ODU4NTE1NyJdLCJlbWFpbCI6WyJiaWpveS5oYWxkYXI5OTlAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.fg74qIeS3dd13hny1vGbxkwFVHURs8mrHC1P640-9Vb5IBP9qLpC_ZixU4NFsD4OA9l_8G4D2HlcIqXBMSNe5_O0_0mkHQJVIH9CF1YL7huiln08-4-s9kMUJolawQdRSEJ3sUiAiWc5cqHwMZ2jA8JPKg8SuCMNNUlSD9uT2MYgS1p05WVN7QjoPdbSgomBhlca0MCnW2OQUzkX88wRmtrmuIgaMTg2ur2k_mmKAP7AyhcSNoVFNrbm2ZXcZoOcFcCdRHVsPR6q3-8jrFLutKRAWocQ4mf1C5tsnItcuoa63EOmHztlW9OCs2ksGDmuOL_lkMr-UKHTz2rTZD0FQg'};
          DioLogger.onSend(ApiConstant().tag, options);
          log("accessToken${options.headers}");
          return handler.next(options);
        }, onResponse: (Response response, handler) {
          DioLogger.onSuccess(ApiConstant().tag, response);
          return handler.next(response);
        }, onError: (DioException error, handler) {
          logOutUser();
          _dioError = error;
          DioLogger.onError(ApiConstant().tag, error);
          return handler.next(error);
        }));
  }

// Generic Get Api Function
  Future<T> getApiData<T>(
      String endpoint,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    try {
      log("endpoint ${endpoint}");
      Response res = await _dio.get(endpoint);
      return fromJson(res.data);
    } on DioException catch (e) {
      log('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  // Generic Post Function
  Future<T> postApiData<T>(
      String endpoint,
      Map<String, dynamic> params,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    try {
      var data = json.encode(params);

      logWithColor('POST Params: $data', color: '\x1B[36m');
      logWithColor('POST Endpoint: $endpoint', color: '\x1B[36m'); // Cyan color


      Response response =
      await _dio.post(endpoint, data: data);
      return fromJson(response.data);
    } on DioException catch (e) {
      logWithColor('Error: ${e.response?.data ?? e.message}', color: '\x1B[31m');
      rethrow;
    }
  }

  Future<T> getApiFormData<T>(
      String endpoint,
      Map<String, dynamic> params,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    try {
      FormData formData = FormData.fromMap(params);

      logWithColor('POST (FormData) Params: $params', color: '\x1B[36m');
      logWithColor('POST Endpoint: $endpoint', color: '\x1B[36m');

      Response response = await _dio.get(
        endpoint,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return fromJson(response.data);
    } on DioException catch (e) {
      logWithColor('Error: ${e.response?.data ?? e.message}', color: '\x1B[31m');
      rethrow;
    }
  }


  // Generic PATCH API Function
  Future<T> patchApiData<T>(
      String endpoint,
      Map<String, dynamic> params,
      T Function(dynamic) fromJson,
      ) async {
    try {
      var data = json.encode(params);

      logWithColor('Get Params: $data', color: '\x1B[36m');
      logWithColor('Get Endpoint: $endpoint', color: '\x1B[36m'); // Cyan color

      Response response = await _dio.patch(endpoint, data: data);
      return fromJson(response.data);
    } on DioException catch (e) {
      logWithColor('Error: ${e.response?.data ?? e.message}', color: '\x1B[31m');
      rethrow;
    }
  }

  // Generic DELETE API Function
  Future<T> deleteApiData<T>(
      String endpoint,
      Map<String, dynamic>? params,
      T Function(dynamic) fromJson,
      ) async {
    try {
      log('DELETE Params: $params');
      log('DELETE Endpoint: $endpoint');

      Response response = await _dio.delete(
        endpoint,
        data: params != null ? json.encode(params) : null,
      );
      return fromJson(response.data);
    } on DioException catch (e) {
      logWithColor('Error: ${e.response?.data ?? e.message}', color: '\x1B[31m');
      rethrow;
    }
  }

  logOutUser() async {
    // PrefManager.remove(AppConstants.loggedIn);
    // PrefManager.remove(AppConstants.accessToken);
    // Get.offAllNamed(Routes.authScreen);
  }



}
