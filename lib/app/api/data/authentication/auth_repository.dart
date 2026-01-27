import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/data/user/user_model.dart';
import 'package:sounds_good_app/app/api/service/authentication/authentication_service.dart';

class AuthRepository {
  final AuthenticationService _service = AuthenticationService();

  final Box authBox = Hive.box('authBox');
  final Box<UserModel> userBox = Hive.box<UserModel>('userBox');

  Future<UserModel> login(String email, String password) async {
    final result = await _service.login(email, password);

    await authBox.put('userToken', result.token);
    await userBox.put('current_user', result.user);

    return result.user;
  }

  UserModel? getCachedUser() {
    return userBox.get('current_user');
  }

  void logout() {
    authBox.clear();
    userBox.clear();
  }
}
