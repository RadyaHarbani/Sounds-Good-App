import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';
import 'favorite_page_controller.dart';

class FavoritePageView extends StatelessWidget {
  final FavoritePageController controller = Get.find<FavoritePageController>();
  final AudioController audioController = Get.find<AudioController>();
  FavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Scaffold(
      backgroundColor: backgroundColor,

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
              'FAVORITE',
              style: tsTitleLargeBold(context, blackColor),
            ),
          ),
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
                itemCount: controller.favorites.length,

                itemBuilder: (context, index) {
                  final music = controller.favorites[index];
                  return GestureDetector(
                    onTap: () {
                      audioController.setPlaylist(
                        controller.favorites,
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
                        SizedBox(height: height * 0.018),
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
