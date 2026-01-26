import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/home-page/home_page_controller.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';
import 'package:sounds_good_app/app/pages/navbar/navbar_main_controller.dart';
import 'package:sounds_good_app/app/pages/search-page/search_page_controller.dart';

class NavbarMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarMainController>(() => NavbarMainController(), fenix: true);

    Get.lazyPut<LibraryPageController>(() => LibraryPageController());
    Get.lazyPut<SearchPageController>(() => SearchPageController());
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}