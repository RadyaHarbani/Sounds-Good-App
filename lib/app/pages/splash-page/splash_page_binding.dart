import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/splash-page/splash_page_controller.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashPageController());
  }
}
