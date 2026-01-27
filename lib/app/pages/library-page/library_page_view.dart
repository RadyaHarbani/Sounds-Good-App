import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/common_alert_dialog.dart';
import 'package:sounds_good_app/app/global/global-components/common_warning.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';
import 'package:sounds_good_app/app/pages/library-page/widgets/bottomsheet_add_music.dart';
import 'package:sounds_good_app/app/pages/library-page/widgets/bottomsheet_update_music.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class LibraryPageView extends StatelessWidget {
  final LibraryPageController controller = Get.find<LibraryPageController>();
  final AudioController audioController = Get.find<AudioController>();

  LibraryPageView({super.key});

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
              'YOUR LIBRARY',
              style: tsTitleLargeBold(context, blackColor),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: width * 0.06),
              child: IconButton(
                icon: Icon(Icons.add, color: blackColor, size: 30),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: whiteColor,
                    builder: (context) => BottomsheetAddMusic(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
            child: Obx(
              () => controller.userMusics.length == 0
                  ? Center(
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/images/emptyLibrary.svg'),
                          Text(
                            'No music in your library.',
                            style: tsBodyMediumRegular(context, greyColor),
                          ),
                        ],
                      ),
                    )
                  : SlidableAutoCloseBehavior(
                      child: Column(
                        children: [
                          CommonWarning(
                            backColor: warningColor.withValues(alpha: 0.1),
                            text: "Slide left on a music to see options.",
                          ),
                          SizedBox(height: height * 0.02),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.userMusics.length,

                            itemBuilder: (context, index) {
                              final music = controller.userMusics[index];

                              return Slidable(
                                key: ValueKey(music.id),
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  extentRatio: 0.4,
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: whiteColor,
                                          builder: (context) =>
                                              BottomsheetUpdateMusic(
                                                musicId: music.id,
                                                title: music.title,
                                                artist: music.artist,
                                              ),
                                        );
                                      },
                                      backgroundColor: orangeColor.withValues(
                                        alpha: 0.1,
                                      ),
                                      foregroundColor: orangeColor,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    SlidableAction(
                                      onPressed: (_) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CommonAlertDialog(
                                              title: 'Confirm Deletion',
                                              content:
                                                  'Are you sure you want to delete this music from your library?',
                                              cancelButtonText: 'No',
                                              confirmButtonText: 'Yes',
                                              onConfirm: () {
                                                Get.back();
                                                controller.deleteUserMusic(
                                                  music.id,
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: dangerColor.withValues(
                                        alpha: 0.1,
                                      ),
                                      foregroundColor: dangerColor,
                                      icon: Icons.delete,
                                      label: 'Hapus',
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    audioController.setPlaylist(
                                      controller.userMusics,
                                      startIndex: index,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.network(
                                              music.thumbnailUrl,
                                              width: width * 0.14,
                                              height: height * 0.065,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  Container(
                                                    width: width * 0.14,
                                                    height: height * 0.065,
                                                    color: greyColor.withValues(
                                                      alpha: 0.2,
                                                    ),
                                                    child: Icon(
                                                      Icons.music_note,
                                                      color: greyColor,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                          SizedBox(width: width * 0.04),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                style: tsBodySmallRegular(
                                                  context,
                                                  greyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.02),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
