import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/navbar/navbar_main_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class NavbarMainView extends GetView<NavbarMainController> {
  const NavbarMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Obx(() => controller.pages[controller.currentIndex.value]),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icLightHome.svg'),
              activeIcon: SvgPicture.asset('assets/icons/icFilledHome.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icLightSearch.svg'),
              activeIcon: SvgPicture.asset('assets/icons/icFilledSearch.svg'),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icLightLibrary.svg'),
              activeIcon: SvgPicture.asset('assets/icons/icFilledLibrary.svg'),
              label: 'Library',
            ),
          ],
          backgroundColor: whiteColor,
          currentIndex: controller.currentIndex.value,
          unselectedLabelStyle: tsLabelLargeMedium(context, greyColor),
          selectedLabelStyle: tsLabelLargeMedium(context, primaryColor),
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.selectedPage(index);
          },
        ),
      ),
    );
  }
}
