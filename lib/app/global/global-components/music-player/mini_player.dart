import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/music-player/full_player.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class MiniPlayer extends StatelessWidget {
  final AudioController controller = Get.find<AudioController>();

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;

    return Obx(() {
      if (controller.currentTitle.value.isEmpty) {
        return const SizedBox();
      }

      return GestureDetector(
        onTap: () => Get.to(() => FullPlayerPage()),
        child: Container(
          height: height * 0.09,
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          decoration: BoxDecoration(
            color: blackColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              /// 🎵 THUMBNAIL
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  controller.currentThumbnail.value,
                  width: width * 0.13,
                  height: height * 0.06,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: width * 0.13,
                    height: height * 0.06,
                    color: Colors.grey.shade800,
                    child: const Icon(Icons.music_note, color: whiteColor),
                  ),
                ),
              ),

              SizedBox(width: width * 0.03),

              /// 🎶 TITLE + ARTIST
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.currentTitle.value,
                      style: tsBodyMediumMedium(context, whiteColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      controller.currentArtist.value,
                      style: tsBodySmallRegular(
                        context,
                        whiteColor.withValues(alpha: 0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(Icons.skip_previous),
                color: whiteColor,
                onPressed: controller.playPrevious,
              ),

              IconButton(
                icon: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                ),
                color: whiteColor,
                onPressed: controller.togglePlay,
              ),

              IconButton(
                icon: const Icon(Icons.skip_next),
                color: whiteColor,
                onPressed: controller.playNext,
              ),
            ],
          ),
        ),
      );
    });
  }
}
