part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const NAVBAR = _Paths.NAVBAR;
  static const SPLASH_PAGE = _Paths.SPLASH_PAGE;
  static const LOGIN_PAGE = _Paths.LOGIN_PAGE;
  static const SIGNUP_PAGE = _Paths.SIGNUP_PAGE;
  static const ONBOARDING_PAGE = _Paths.ONBOARDING_PAGE;
}

abstract class _Paths {
  _Paths._();
  static const NAVBAR = '/navbar';
  static const SPLASH_PAGE = '/splash-page';
  static const LOGIN_PAGE = '/login-page';
  static const SIGNUP_PAGE = '/signup-page';
  static const ONBOARDING_PAGE = '/onboarding-page';
}

