import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/signup-page/signup_page_controller.dart';

class SignupPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupPageController>(() => SignupPageController());
  }
}