import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/common_button.dart';
import 'package:sounds_good_app/app/pages/onboarding-page/onboarding_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

class OnboardingPageView extends GetView<OnboardingPageController> {
  const OnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: height * 0.03,
            left: width * 0.06,
            right: width * 0.06,
            bottom: height * 0.035,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/icons/icApplicationLogo.png',
                  width: width * 0.2,
                ),
              ),
              SizedBox(height: height * 0.05),
              Text(
                'SoundsGood',
                style: tsBodyMediumSemibold(context, primaryColor),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Not Just Listening, You’re in Control of the Sound.',
                style: tsHeadingLargeBold(
                  context,
                  blackColor,
                ).copyWith(height: 1.1),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'An interactive music app where users can create, customize, and organize their own songs while enjoying a curated default collection.',
                style: tsBodyMediumRegular(
                  context,
                  blackColor,
                ).copyWith(height: 1.2),
              ),
              SizedBox(height: height * 0.1),
              CommonButton(
                text: "Login",
                backgroundColor: blackColor,
                textColor: whiteColor,
                onPressed: () {
                  Get.toNamed(Routes.LOGIN_PAGE);
                },
              ),
              SizedBox(height: height * 0.008),
              CommonButton(
                text: "Sign Up",
                backgroundColor: whiteColor,
                textColor: primaryColor,
                isBordered: true,
                onPressed: () {
                  Get.toNamed(Routes.SIGNUP_PAGE);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
