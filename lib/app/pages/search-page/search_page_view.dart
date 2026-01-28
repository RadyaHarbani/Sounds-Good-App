import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/common_text_field.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/app/pages/search-page/search_page_controller.dart';
import 'package:sounds_good_app/app/pages/search-page/widget/music_item.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class SearchPageView extends StatelessWidget {
  final SearchPageController controller = Get.find<SearchPageController>();
  final AudioController audioController = Get.find<AudioController>();
  SearchPageView({super.key});

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
            child: Text('SEARCH', style: tsTitleLargeBold(context, blackColor)),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
          child: Column(
            children: [
              Obx(
                () => CommonTextField(
                  fieldController: controller.searchController,
                  obscureText: false,
                  hintText: 'Title, artist',
                  keyboardType: TextInputType.name,
                  onChanged: controller.search,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.searchController.text = '';
                      controller.isSearching.value = false;
                      controller.search("");
                    },
                    icon: controller.isSearching.value == true
                        ? Icon(Icons.close_rounded, size: 20)
                        : SizedBox.shrink(),
                  ),
                ),
              ),
              Obx(() {
                final defaultMusics = controller.shownDefaultMusics;
                final userMusics = controller.shownUserMusics;
                final favoriteMusics = controller.shownFavoriteMusics;

                if (defaultMusics.isEmpty && userMusics.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/emptySearch.svg'),
                          Text(
                            'No music found',
                            style: tsBodyMediumRegular(context, greyColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userMusics.isNotEmpty) ...[
                          SizedBox(height: height * 0.02),
                          Text(
                            'YOUR MUSIC',
                            style: tsBodyMediumMedium(context, greyColor),
                          ),
                          SizedBox(height: height * 0.02),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: userMusics.length,
                            itemBuilder: (context, index) {
                              final music = userMusics[index];
                              return MusicItem(
                                music: music,
                                width: width,
                                height: height,
                                onTap: () {
                                  audioController.setPlaylist(
                                    userMusics,
                                    startIndex: index,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                        if (favoriteMusics.isNotEmpty) ...[
                          SizedBox(height: height * 0.02),
                          Text(
                            'YOUR FAVORITE',
                            style: tsBodyMediumMedium(context, greyColor),
                          ),
                          SizedBox(height: height * 0.02),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: favoriteMusics.length,
                            itemBuilder: (context, index) {
                              final music = favoriteMusics[index];
                              return MusicItem(
                                music: music,
                                width: width,
                                height: height,
                                onTap: () {
                                  audioController.setPlaylist(
                                    favoriteMusics,
                                    startIndex: index,
                                  );
                                },
                              );
                            },
                          ),
                        ],

                        if (defaultMusics.isNotEmpty) ...[
                          SizedBox(height: height * 0.02),
                          Text(
                            'DEFAULT MUSIC',
                            style: tsBodyMediumMedium(context, greyColor),
                          ),
                          SizedBox(height: height * 0.02),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: defaultMusics.length,
                            itemBuilder: (context, index) {
                              final music = defaultMusics[index];
                              return MusicItem(
                                music: music,
                                width: width,
                                height: height,
                                onTap: () {
                                  audioController.setPlaylist(
                                    defaultMusics,
                                    startIndex: index,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: height * 0.1),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
