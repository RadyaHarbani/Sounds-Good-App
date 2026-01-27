import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-controllers/audio_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class FullPlayerPage extends StatelessWidget {
  final AudioController controller = Get.find<AudioController>();

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
                  controller.currentThumbnail.value,
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

              Text(
                controller.currentTitle.value,
                style: tsHeadingSmallBold(context, blackColor),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                controller.currentArtist.value,
                style: tsBodyMediumRegular(context, greyColor),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: height * 0.06),

              StreamBuilder<Duration>(
                stream: controller.player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = controller.player.duration ?? Duration.zero;

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
                          controller.player.seek(
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
                    onPressed: controller.playPrevious,
                  ),

                  SizedBox(width: width * 0.03),

                  IconButton(
                    iconSize: 72,
                    color: blackColor,
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_circle
                          : Icons.play_circle,
                    ),
                    onPressed: controller.togglePlay,
                  ),

                  SizedBox(width: width * 0.03),

                  IconButton(
                    iconSize: 36,
                    color: blackColor,
                    icon: const Icon(Icons.skip_next),
                    onPressed: controller.playNext,
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
