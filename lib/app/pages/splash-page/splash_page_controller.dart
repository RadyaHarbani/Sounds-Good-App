import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('SplashPageController initialized');
    Future.delayed(const Duration(seconds: 2), () {
      final box = Hive.box('authBox');
      final token = box.get('userToken');

      if (token != null && token.toString().isNotEmpty) {
        Get.offAllNamed(Routes.NAVBAR);
      } else {
        Get.offAllNamed(Routes.ONBOARDING_PAGE);
      }
    });
  }
}
