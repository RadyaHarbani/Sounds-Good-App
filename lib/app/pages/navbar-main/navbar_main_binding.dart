import 'package:get/get.dart';

class NavbarMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarMainController>(() => NavbarMainController());
  }
}