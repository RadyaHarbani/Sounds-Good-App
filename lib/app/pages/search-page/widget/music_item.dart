import 'package:flutter/material.dart';
import 'package:sounds_good_app/common/helper/themes.dart';
import 'package:sounds_good_app/app/api/data/music/music_model.dart';

class MusicItem extends StatelessWidget {
  final MusicModel music;
  final VoidCallback onTap;
  final double width;
  final double height;

  const MusicItem({
    super.key,
    required this.music,
    required this.onTap,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: height * 0.018),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                music.thumbnailUrl,
                width: width * 0.14,
                height: height * 0.065,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: width * 0.14,
                  height: height * 0.065,
                  color: greyColor.withValues(alpha: 0.2),
                  child: Icon(Icons.music_note, color: greyColor),
                ),
              ),
            ),
            SizedBox(width: width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  music.title,
                  style: tsBodyMediumSemibold(context, blackColor),
                ),
                Text(
                  music.artist,
                  style: tsBodySmallRegular(context, greyColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
