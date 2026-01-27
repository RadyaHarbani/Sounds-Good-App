// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool? isLoading;
  final bool? isBordered;

  CommonButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
    this.icon,
    this.isLoading,
    this.isBordered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: width,
        height: height * 0.068,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          border: isBordered == true
              ? Border.all(color: primaryColor, width: 1.5)
              : null,
        ),
        alignment: Alignment.center,
        child: isLoading == true
            ? SizedBox(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: whiteColor,
                  size: height * 0.035,
                ),
              )
            : isLoading == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text, style: tsBodyMediumSemibold(context, textColor)),
                  if (icon != null) ...[
                    SizedBox(width: 10),
                    Icon(icon, color: textColor, size: 18),
                  ],
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text, style: tsBodyMediumSemibold(context, textColor)),
                  if (icon != null) ...[
                    SizedBox(width: 10),
                    Icon(icon, color: textColor, size: 18),
                  ],
                ],
              ),
      ),
    );
  }
}
