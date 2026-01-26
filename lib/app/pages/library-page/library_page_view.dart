import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class LibraryPageView extends GetView<LibraryPageController> {
  const LibraryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      //   backgroundColor: backgroundColor,
      //   body: SingleChildScrollView(
      //     child: SafeArea(
      //       child: Padding(
      //         padding: EdgeInsets.only(
      //           top: height * 0.03,
      //           left: width * 0.05,
      //           right: width * 0.05,
      //         ),
      //         child: Form(
      //           key: controller.formKey,
      //           child: Column(
      //             children: [
      //               Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   SvgPicture.asset(
      //                     'assets/icons/icLogoFunEducation.svg',
      //                     width: width * 0.08,
      //                   ),
      //                   SizedBox(width: width * 0.01),
      //                   AutoSizeText(
      //                     'Fun Education',
      //                     group: AutoSizeGroup(),
      //                     maxLines: 1,
      //                     style: tsBodyLargeSemibold(primaryColor),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(height: height * 0.04),
      //               Column(
      //                 children: [
      //                   SvgPicture.asset('assets/images/welcome_login_page.svg'),
      //                   AutoSizeText.rich(
      //                     group: AutoSizeGroup(),
      //                     textAlign: TextAlign.center,
      //                     TextSpan(
      //                       text: 'Selamat Datang di\n',
      //                       style: tsTitleMediumRegular(blackColor).copyWith(
      //                         height: 1.3,
      //                       ),
      //                       children: [
      //                         TextSpan(
      //                           text: 'Fun Education',
      //                           style: tsTitleMediumSemibold(blackColor),
      //                         ),
      //                       ],
      //                     ),
      //                     maxLines: 2,
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(height: height * 0.06),
      //               CommonWarning(
      //                 backColor: warningColor,
      //                 text:
      //                     'Isi dengan kata sandi yang telah diberikan oleh guru',
      //               ),
      //               SizedBox(height: height * 0.03),
      //               Column(
      //                 children: [
      //                   CommonTextField(
      //                     fieldController: controller.emailController,
      //                     obscureText: false,
      //                     hintText: 'Masukkan Email',
      //                     keyboardType: TextInputType.emailAddress,
      //                     validator: (value) {
      //                       if (value == null || value.isEmpty) {
      //                         return 'Please enter an email address';
      //                       }
      //                       final emailRegex = RegExp(
      //                           r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      //                           r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      //                           r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      //                           r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      //                           r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      //                           r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      //                           r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');
      //                       if (!emailRegex.hasMatch(value)) {
      //                         return 'Please enter a valid email address';
      //                       }
      //                       return null;
      //                     },
      //                   ),
      //                   SizedBox(height: height * 0.01),
      //                   Obx(
      //                     () => CommonTextField(
      //                       fieldController: controller.passwordController,
      //                       obscureText: controller.isObsecure.value,
      //                       hintText: 'Masukkan Kata Sandi',
      //                       keyboardType: TextInputType.name,
      //                       suffixIcon: IconButton(
      //                         onPressed: () {
      //                           controller.isObsecure.value =
      //                               !controller.isObsecure.value;
      //                         },
      //                         icon: Icon(
      //                           controller.isObsecure.value
      //                               ? Icons.visibility_off
      //                               : Icons.visibility,
      //                           size: 20,
      //                           color: greyColor,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Container(
      //                 width: width,
      //                 alignment: Alignment.centerRight,
      //                 child: TextButton(
      //                   onPressed: () {
      //                     showModalBottomSheet(
      //                       context: context,
      //                       isScrollControlled: true,
      //                       backgroundColor: whiteColor,
      //                       builder: (context) =>
      //                           BottomsheetAddEmailResetPassword(),
      //                     );
      //                   },
      //                   child: AutoSizeText(
      //                     'Lupa Kata Sandi?',
      //                     style: tsBodySmallRegular(blackColor),
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: height * 0.02),
      //               Obx(() => CommonButton(
      //                     isLoading: controller.isLoadingLogin.value,
      //                     text: 'Masuk',
      //                     backgroundColor: blackColor,
      //                     textColor: whiteColor,
      //                     onPressed: () {
      //                       controller.login();
      //                     },
      //                   )),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}
