import 'package:get/get.dart';
import 'package:sounds_good_app/app/pages/login-page/login_page_binding.dart';
import 'package:sounds_good_app/app/pages/login-page/login_page_view.dart';
import 'package:sounds_good_app/app/pages/navbar/navbar_main_binding.dart';
import 'package:sounds_good_app/app/pages/navbar/navbar_main_view.dart';
import 'package:sounds_good_app/app/pages/onboarding-page/onboarding_page_binding.dart';
import 'package:sounds_good_app/app/pages/onboarding-page/onboarding_page_view.dart';
import 'package:sounds_good_app/app/pages/signup-page/signup_page_view.dart';
import 'package:sounds_good_app/app/pages/signup-page/signup_page_binding.dart';
import 'package:sounds_good_app/app/pages/splash-page/splash_page_binding.dart';
import 'package:sounds_good_app/app/pages/splash-page/splash_page_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.NAVBAR,
      page: () => NavbarMainView(),
      binding: NavbarMainBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_PAGE,
      page: () => SplashPageView(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_PAGE,
      page: () => SignupPageView(),
      binding: SignupPageBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_PAGE,
      page: () => OnboardingPageView(),
      binding: OnboardingPageBinding(),
    ),
    // GetPage(
    //   name: _Paths.HOME_PAGE,
    //   page: () => HomePageView(),
    //   binding: HomePageBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SEARCH_PAGE,
    //   page: () => SearchPageView(),
    //   binding: SearchPageBinding(),
    // ),
    // GetPage(
    //   name: _Paths.LIBRARY_PAGE,
    //   page: () => LibraryPageView(),
    //   binding: LibraryPageBinding(),
    // ),
  ];
}
