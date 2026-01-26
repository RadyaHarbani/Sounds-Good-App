import 'package:flutter/material.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class CommonWarning extends StatelessWidget {
  final Color backColor;
  final String text;

  CommonWarning({
    Key? key,
    required this.backColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backColor,
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: whiteColor,
            size: width * 0.06,
          ),
          SizedBox(width: width * 0.025),
          Flexible(
            child: Text(
              text,
              maxLines: 2,
              style: tsBodySmallMedium(context, whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
