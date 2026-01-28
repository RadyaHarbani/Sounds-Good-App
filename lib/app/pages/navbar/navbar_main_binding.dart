import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/app/pages/favorite-page/favorite_page_controller.dart';
import 'package:sounds_good_app/app/pages/home-page/home_page_controller.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';
import 'package:sounds_good_app/app/pages/navbar/navbar_main_controller.dart';
import 'package:sounds_good_app/app/pages/search-page/search_page_controller.dart';

class NavbarMainBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(RecentlyPlayedController(), permanent: true);
    Get.put(AudioController(), permanent: true);

    Get.lazyPut<NavbarMainController>(
      () => NavbarMainController(),
      fenix: true,
    );

    Get.lazyPut<HomePageController>(() => HomePageController(), fenix: true);

    Get.lazyPut<SearchPageController>(
      () => SearchPageController(),
      fenix: true,
    );

    Get.lazyPut<FavoritePageController>(
      () => FavoritePageController(),
      fenix: true,
    );

    Get.lazyPut<LibraryPageController>(
      () => LibraryPageController(),
      fenix: true,
    );
  }
}
