import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/login-page/login_page_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(() => LoginPageController());
  }
}