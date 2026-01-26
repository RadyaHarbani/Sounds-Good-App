import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global-components/common_button.dart';
import 'package:sounds_good_app/app/global-components/common_text_field.dart';
import 'package:sounds_good_app/app/pages/login-page/login_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

class LoginPageView extends GetView<LoginPageController> {
  LoginPageView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.05,
                left: width * 0.06,
                right: width * 0.06,
                bottom: height * 0.02,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/icons/icApplicationLogo.png',
                            width: width * 0.15,
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Text(
                          'Welcome Back!',
                          style: tsHeadingLargeBold(context, blackColor),
                        ),

                        Text(
                          'Login to your account to get started.',
                          style: tsBodyMediumRegular(context, greyColor),
                        ),
                        SizedBox(height: height * 0.04),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextField(
                              fieldController: controller.emailController,
                              obscureText: false,
                              hintText: 'Enter Email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address';
                                }
                                final emailRegex = RegExp(
                                  r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.01),
                            Obx(
                              () => CommonTextField(
                                fieldController: controller.passwordController,
                                obscureText: controller.isObsecure.value,
                                hintText: 'Enter Password',
                                keyboardType: TextInputType.name,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isObsecure.value =
                                        !controller.isObsecure.value;
                                  },
                                  icon: Icon(
                                    controller.isObsecure.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 20,
                                    color: greyColor,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an password';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(
                          () => CommonButton(
                            isLoading: controller.isLoadingLogin.value,
                            text: 'Login',
                            backgroundColor: blackColor,
                            textColor: whiteColor,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.login();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        CommonButton(
                          text: "Create an account",
                          backgroundColor: whiteColor,
                          textColor: primaryColor,
                          isBordered: true,
                          onPressed: () {
                            Get.offNamed(Routes.SIGNUP_PAGE);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
