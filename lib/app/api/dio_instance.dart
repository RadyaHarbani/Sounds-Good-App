import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/api_endpoints.dart';

class DioInstance {
  late final Dio _dio;

  DioInstance() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    _initializeInterceptors();
  }

  Map<String, dynamic> _headers({
    required bool isAuthorize,
    required bool isMultipart,
  }) {
    final box = Hive.box('authBox');
    final token = box.get('userToken');

    return {
      if (isAuthorize && token != null && isMultipart == false)
        "Content-Type": "application/json",
      if (isAuthorize && token != null && isMultipart == true)
        "Content-Type": Headers.multipartFormDataContentType,
      if (isAuthorize && token != null) "x-auth-token": "$token",
    };
  }

  Future<Response> getRequest({
    required String endpoint,
    required bool isAuthorize,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: _headers(isAuthorize: isAuthorize, isMultipart: false),
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Response> postRequest({
    required String endpoint,
    required Object data,
    required bool isAuthorize,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: _headers(isAuthorize: isAuthorize, isMultipart: true),
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Response> putRequest({
    required String endpoint,
    required Object data,
    required bool isAuthorize,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: _headers(isAuthorize: isAuthorize, isMultipart: false),
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Response> deleteRequest({
    required String endpoint,
    required bool isAuthorize,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: _headers(isAuthorize: isAuthorize, isMultipart: false),
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          print('[API] ${request.method} ${request.path}');
          return handler.next(request);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }
}
