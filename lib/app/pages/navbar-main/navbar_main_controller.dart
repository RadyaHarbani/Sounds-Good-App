import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/home-page/home_page_view.dart';

class NavbarMainController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      currentIndex.value = Get.arguments;
    }
  }

  final List<Widget> pages = [
    HomePageView(),
    HomeSavingPageView(),
    // EventCalendarPageView(),
    GalleryPageView(),
  ];

  void selectedPage(int index) {
    currentIndex.value = index;
  }
}
