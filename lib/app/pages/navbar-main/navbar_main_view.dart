import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_education_app_teacher/app/pages/navbar-main/navbar_main_controller.dart';
import 'package:fun_education_app_teacher/common/helper/themes.dart';
import 'package:get/get.dart';

class NavbarMainView extends GetView<NavbarMainController> {
  const NavbarMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icHome.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/icHome.svg',
                color: primaryColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icSavings.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/icSavings.svg',
                color: primaryColor,
              ),
              label: 'Tabungan',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset('assets/icons/icEventCalendar.svg'),
            //   activeIcon: SvgPicture.asset(
            //     'assets/icons/icEventCalendar.svg',
            //     color: primaryColor,
            //   ),
            //   label: 'Kalender',
            // ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/icGallery.svg'),
              activeIcon: SvgPicture.asset(
                'assets/icons/icGallery.svg',
                color: primaryColor,
              ),
              label: 'Gallery',
            ),
          ],
          backgroundColor: whiteColor,
          currentIndex: controller.currentIndex.value,
          unselectedLabelStyle: tsLabelLargeMedium(greyColor),
          selectedLabelStyle: tsLabelLargeMedium(primaryColor),
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
