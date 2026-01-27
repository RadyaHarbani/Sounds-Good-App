import 'package:sounds_good_app/app/api/api_endpoints.dart';
import 'package:sounds_good_app/app/api/data/user/user_model.dart';
import 'package:sounds_good_app/app/api/dio_instance.dart';

class UserService {
  final DioInstance _dio = DioInstance();

  Future<UserModel> getCurrentUser() async {
    final response = await _dio.getRequest(
      endpoint: ApiEndpoints.currentUserData,
      isAuthorize: true,
    );

    return UserModel.fromJson(response.data);
  }
}