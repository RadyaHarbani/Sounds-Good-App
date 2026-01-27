import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/api/service/authentication/authentication_service.dart';
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
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      switch (statusCode) {
        case 400:
          Get.snackbar(
            "Signup Error",
            "Account already exists with this email",
          );
          break;
        case 422:
          Get.snackbar("Signup Error", "Invalid input. Please check your data");
          break;
        case 500:
          Get.snackbar("Signup Error", "Server error. Please try again later");
          break;
        default:
          Get.snackbar(
            "Signup Error",
            "Network error. Please check your connection",
          );
      }
    } catch (e) {
      Get.snackbar("Signup Error", "Something went wrong. Please try again");
    } finally {
      isLoadingSignup(false);
    }
  }
}
