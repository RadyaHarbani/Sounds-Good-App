import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/common_button.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/app/pages/home-page/home_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class HomePageView extends StatelessWidget {
  final HomePageController controller = Get.find<HomePageController>();
  final AudioController audioController = Get.find<AudioController>();
  HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: backgroundColor,
      onDrawerChanged: (isOpen) {
        controller.isDrawerOpen.value = isOpen;
      },
      drawer: Drawer(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        width: width * 0.85,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),
              Container(
                height: height * 0.05,
                width: width * 0.11,
                decoration: BoxDecoration(
                  border: Border.all(color: greyColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close, size: 20),
                ),
              ),

              SizedBox(height: height * 0.04),
              Obx(() {
                if (controller.user.value == null) {
                  return SizedBox.shrink();
                }
                return Text(
                  '${controller.user.value!.name}!',
                  style: tsHeadingMediumBold(context, blackColor),
                );
              }),
              Obx(() {
                if (controller.user.value == null) {
                  return SizedBox.shrink();
                }
                return Text(
                  controller.user.value!.email,
                  style: tsBodyMediumRegular(context, greyColor),
                );
              }),

              Spacer(),
              Obx(
                () => CommonButton(
                  isLoading: controller.isLoadingLogout.value,
                  text: 'Logout',
                  icon: Icons.logout,
                  backgroundColor: dangerColor,
                  textColor: whiteColor,
                  onPressed: () {
                    controller.logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.06),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left: width * 0.026),
            child: Text(
              'HOMEPAGE',
              style: tsTitleLargeBold(context, blackColor),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: width * 0.06),
              child: IconButton(
                icon: Icon(Icons.person, color: blackColor, size: 30),
                onPressed: () {
                  controller.openDrawer();
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
              left: width * 0.06,
              right: width * 0.06,
            ),
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.musics.length,

                itemBuilder: (context, index) {
                  final music = controller.musics[index];
                  return GestureDetector(
                    onTap: () {
                      audioController.setPlaylist(
                        controller.musics,
                        startIndex: index,
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                music.thumbnailUrl,
                                width: width * 0.14,
                                height: height * 0.065,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: width * 0.14,
                                        height: height * 0.065,
                                        color: greyColor.withValues(alpha: 0.2),
                                        child: Icon(
                                          Icons.music_note,
                                          color: greyColor,
                                          size: 30,
                                        ),
                                      );
                                    },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: width * 0.14,
                                    height: height * 0.065,
                                    color: greyColor.withValues(alpha: 0.2),
                                    child: Icon(
                                      Icons.music_note,
                                      color: greyColor,
                                      size: 30,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: width * 0.04),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  music.title,
                                  style: tsBodyMediumSemibold(
                                    context,
                                    blackColor,
                                  ),
                                ),

                                Text(
                                  music.artist,
                                  style: tsBodySmallRegular(context, greyColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
