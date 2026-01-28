import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/music-player/mini_player.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/app/pages/home-page/home_page_controller.dart';
import 'package:sounds_good_app/app/pages/navbar/navbar_main_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class NavbarMainView extends GetView<NavbarMainController> {
  const NavbarMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => IndexedStack(
              index: controller.currentIndex.value,
              children: controller.pages,
            ),
          ),

          Positioned(
            left: width * 0.04,
            right: width * 0.04,
            bottom: height * 0.01,
            child: Obx(() {
              final homeController = Get.find<HomePageController>();
              final audioController = Get.find<AudioController>();

              final showMiniPlayer =
                  !homeController.isDrawerOpen.value &&
                  audioController.hasActiveAudio.value;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: showMiniPlayer ? MiniPlayer() : const SizedBox.shrink(),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
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
                icon: SvgPicture.asset('assets/icons/icLightFavorite.svg'),
                activeIcon: SvgPicture.asset(
                  'assets/icons/icFilledFavorite.svg',
                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/icLightLibrary.svg'),
                activeIcon: SvgPicture.asset(
                  'assets/icons/icFilledLibrary.svg',
                ),
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
      ),
    );
  }
}
