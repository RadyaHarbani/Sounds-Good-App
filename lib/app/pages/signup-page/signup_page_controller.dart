import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/api/authentication/service/authentication_service.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

class SignupPageController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AuthenticationService authenticationService;
  RxBool isObsecure = true.obs;
  RxBool isLoadingSignup = false.obs;

  @override
  void onInit() {
    super.onInit();
    authenticationService = AuthenticationService();
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    try {
      isLoadingSignup(true);
      await authenticationService.signup(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      Get.snackbar("Signup Success", "Account created successfully!");
      Get.toNamed(
        Routes.LOGIN_PAGE,
        arguments: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
    } catch (e) {
      isLoadingSignup(false);
      if (e.toString().contains('400')) {
        Get.snackbar("Signup Error", "Account already exists with this email.");
      } else if (e.toString().contains('500')) {
        Get.snackbar("Signup Error", "Server error. Please try again later.");
      } else if (e.toString().contains('DioException')) {
        Get.snackbar(
          "Signup Error",
          "Network error. Please check your connection.",
        );
      } else if (e.toString().contains('422')) {
        Get.snackbar(
          "Signup Error",
          "Invalid input. Please check your email and password.",
        );
      } else {
        Get.snackbar("Signup Error", "Signup failed. Please try again.");
      }
      print(e);
    } finally {
      isLoadingSignup(false);
    }
  }
}
