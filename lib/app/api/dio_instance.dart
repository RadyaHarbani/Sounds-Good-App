import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/api_endpoints.dart';

class DioInstance {
  late Dio _dio;

  DioInstance() {
    _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

    initializeInterceptors();
  }

  Future<Response> getRequest({
    required String endpoint,
    bool? isAuthorize,
    String? tokenType,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;
    final box = Hive.box('authBox');
    final token = box.get('userToken');

    try {
      response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (isAuthorize ?? false) "x-auth-token": "$token",
          },
        ),
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> postRequest({
    required String endpoint,
    bool? isAuthorize,
    String? tokenType,
    required Object data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;
    final box = Hive.box('authBox');
    final token = box.get('userToken');

    try {
      response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (isAuthorize ?? false) "x-auth-token": "$token",
          },
        ),
      );
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> putRequest({
    required String endpoint,
    bool? isAuthorize,
    String? tokenType,
    required Object data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;
    final box = Hive.box('authBox');
    final token = box.get('userToken');

    try {
      response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (isAuthorize ?? false) "x-auth-token": "$token",
          },
        ),
      );
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> deleteRequest({
    required String endpoint,
    bool? isAuthorize,
    String? tokenType,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;
    final box = Hive.box('authBox');
    final token = box.get('userToken');

    try {
      response = await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (isAuthorize ?? false) "x-auth-token": "$token",
          },
        ),
      );
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          return handler.next(error);
        },
        onRequest: (request, handler) {
          print(request.method + " " + request.path);
          print(request.data);
          return handler.next(request);
        },
        onResponse: (response, handler) {
          print(response.data);
          return handler.next(response);
        },
      ),
    );
  }
}
