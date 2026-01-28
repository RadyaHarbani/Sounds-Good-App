import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/app/pages/favorite-page/favorite_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class FullPlayerPage extends StatelessWidget {
  final AudioController audioController = Get.find<AudioController>();
  final FavoritePageController favoriteController =
      Get.find<FavoritePageController>();

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: blackColor),
          onPressed: Get.back,
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.all(width * 0.06),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "${audioController.currentThumbnail.value}",
                  height: height * 0.35,
                  width: width * 0.8,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: height * 0.35,
                    width: width * 0.8,
                    color: greyColor.withValues(alpha: 0.5),
                    child: const Icon(
                      Icons.music_note,
                      size: 120,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.04),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          audioController.currentTitle.value,
                          style: tsHeadingSmallBold(context, blackColor),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: height * 0.005),
                        Text(
                          audioController.currentArtist.value,
                          style: tsBodyMediumRegular(context, greyColor),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Obx(() {
                      final music = audioController.currentMusic;

                      if (music == null) return const SizedBox();

                      final isFav = favoriteController.favoriteIds.contains(
                        music.id,
                      );

                      return IconButton(
                        icon: Icon(
                          size: 30,
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          favoriteController.toggleFavorite(music);
                        },
                      );
                    }),
                  ],
                ),
              ),

              SizedBox(height: height * 0.06),

              StreamBuilder<Duration>(
                stream: audioController.player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration =
                      audioController.player.duration ?? Duration.zero;

                  final maxSeconds = duration.inSeconds > 0
                      ? duration.inSeconds
                      : 1;

                  return Column(
                    children: [
                      Slider(
                        activeColor: primaryColor,
                        value: position.inSeconds
                            .clamp(0, maxSeconds)
                            .toDouble(),
                        max: maxSeconds.toDouble(),
                        onChanged: (value) {
                          audioController.player.seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(position),
                              style: const TextStyle(color: blackColor),
                            ),
                            Text(
                              _formatDuration(duration),
                              style: const TextStyle(color: blackColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: height * 0.04),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 36,
                    color: blackColor,
                    icon: const Icon(Icons.skip_previous),
                    onPressed: audioController.playPrevious,
                  ),

                  SizedBox(width: width * 0.03),

                  IconButton(
                    iconSize: 72,
                    color: blackColor,
                    icon: Icon(
                      audioController.isPlaying.value
                          ? Icons.pause_circle
                          : Icons.play_circle,
                    ),
                    onPressed: audioController.togglePlay,
                  ),

                  SizedBox(width: width * 0.03),

                  IconButton(
                    iconSize: 36,
                    color: blackColor,
                    icon: const Icon(Icons.skip_next),
                    onPressed: audioController.playNext,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
