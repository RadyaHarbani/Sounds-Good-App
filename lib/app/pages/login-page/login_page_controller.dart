import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/api/data/authentication/auth_repository.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

class LoginPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isObsecure = true.obs;
  RxBool isLoadingLogin = false.obs;

  final AuthRepository _authRepository = AuthRepository();
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      emailController.text = Get.arguments['email'] ?? '';
      passwordController.text = Get.arguments['password'] ?? '';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      isLoadingLogin(true);
      await _authRepository.login(
        emailController.text,
        passwordController.text,
      );

      Get.snackbar("Login Success", "Welcome Back!");
      Get.offAllNamed(Routes.NAVBAR);
    } on DioException catch (e) {
      isLoadingLogin(false);

      final statusCode = e.response?.statusCode;

      switch (statusCode) {
        case 400:
        case 422:
          Get.snackbar("Login Error", "Invalid email or password");
          break;
        case 404:
          Get.snackbar("Login Error", "User not found");
          break;
        case 500:
          Get.snackbar("Login Error", "Server error");
          break;
        default:
          Get.snackbar("Login Error", "Network error");
      }
    } catch (e) {
      Get.snackbar("Login Error", "Something went wrong");
    } finally {
      isLoadingLogin(false);
    }
  }
}
