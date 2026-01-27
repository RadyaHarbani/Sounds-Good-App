import 'package:sounds_good_app/app/api/api_endpoints.dart';
import 'package:sounds_good_app/app/api/data/authentication/login_response_model.dart';
import 'package:sounds_good_app/app/api/dio_instance.dart';
import 'package:dio/dio.dart';

class AuthenticationService {
  final DioInstance _dioInstance = DioInstance();

  Future<LoginResponseModel> login(String email, String password) async {
    final response = await _dioInstance.postRequest(
      endpoint: ApiEndpoints.loginUser,
      isAuthorize: false,
      data: {'email': email, 'password': password},
    );

    return LoginResponseModel.fromJson(response.data);
  }

  Future<Response> signup(String name, String email, String password) async {
    try {
      final response = await _dioInstance.postRequest(
        endpoint: ApiEndpoints.signUpUser,
        isAuthorize: false,
        data: {'name': name, 'email': email, 'password': password},
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
