import 'package:sounds_good_app/app/api/api_endpoints.dart';
import 'package:sounds_good_app/app/api/dio_instance.dart';
import 'package:dio/dio.dart';

class AuthenticationService {
  final DioInstance _dioInstance = DioInstance();

  Future<Response> login(String email, String password) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: ApiEndpoints.loginUser,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> signup(String name, String email, String password) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: ApiEndpoints.signUpUser,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}