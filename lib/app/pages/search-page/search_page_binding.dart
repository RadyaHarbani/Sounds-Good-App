import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/search-page/search_page_controller.dart';

class SearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchPageController>(() => SearchPageController());
  }
}