import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/data/user/user_model.dart';
import 'package:sounds_good_app/app/api/service/user/user_service.dart';

class UserRepository {
  final UserService _service = UserService();
  final Box<UserModel> _box = Hive.box<UserModel>('userBox');

  Future<UserModel> getCurrentUser() async {
    try {
      final user = await _service.getCurrentUser();
      await _box.put('current_user', user);
      return user;
    } catch (_) {
      final cached = _box.get('current_user');
      if (cached != null) return cached;
      rethrow;
    }
  }
}