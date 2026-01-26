import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/home-page/home_page_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}