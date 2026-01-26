import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/splash-page/splash_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class SplashPageView extends GetView<SplashPageController> {
  const SplashPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/icons/icApplicationLogo.png',
            width: width * 0.35,
          ),
        ),
      ),
    );
  }
}
