import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sounds_good_app/app/api/authentication/service/authentication_service.dart';
import 'package:sounds_good_app/common/routes/app_pages.dart';

class LoginPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AuthenticationService authenticationService;
  RxBool isObsecure = true.obs;
  RxBool isLoadingLogin = false.obs;
  @override
  void onInit() {
    super.onInit();
    authenticationService = AuthenticationService();
    emailController.text =
        Get.arguments != null && Get.arguments['email'] != null
        ? emailController.text = Get.arguments['email']
        : '';
    Get.arguments != null && Get.arguments['password'] != null
        ? passwordController.text = Get.arguments['password']
        : '';
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
      final response = await authenticationService.login(
        emailController.text,
        passwordController.text,
      );

      final box = Hive.box('authBox');
      box.put('userToken', response.data['token']);

      Get.snackbar("Login Success", "Welcome Back!");
      print("User Token: ${box.get('userToken')}");
      Get.offAllNamed(Routes.NAVBAR);
    } catch (e) {
      isLoadingLogin(false);
      if (e.toString().contains('404')) {
        Get.snackbar("Login Error", "User not found. Please sign up.");
      } else if (e.toString().contains('400')) {
        Get.snackbar(
          "Login Error",
          "Invalid input. Please check your email and password.",
        );
      } else if (e.toString().contains('500')) {
        Get.snackbar("Login Error", "Server error. Please try again later.");
      } else if (e.toString().contains('DioException')) {
        Get.snackbar(
          "Login Error",
          "Network error. Please check your connection.",
        );
      } else if (e.toString().contains('422')) {
        Get.snackbar(
          "Login Error",
          "Invalid input. Please check your email and password.",
        );
      } else {
        Get.snackbar("Login Error", "Invalid Username or Password");
      }
      print(e);
    } finally {
      isLoadingLogin(false);
    }
  }
}
