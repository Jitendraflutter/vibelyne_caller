// routes.dart

import 'package:get/get.dart';
import 'package:voicly/controller/auth/login_controller.dart';
import 'package:voicly/features/auth/auth_screen.dart';
import 'package:voicly/features/coin/coin_screen.dart';
import 'package:voicly/features/home/home_screen.dart';
import 'package:voicly/features/language/language_screen.dart';
import 'package:voicly/features/profile/profile_screen.dart';
import 'package:voicly/features/profile/update_profile_modal.dart';
import 'package:voicly/features/splash/splash_screen.dart';

import '../utils/local_storage.dart';
import 'binding.dart';

// ignore_for_file: constant_identifier_names
class AppRoutes {
  static const SPLASH = '/';
  static const ONBOARDING = '/onboarding';
  static const BOTTOM_BAR = '/bottom_bar';
  static const LOGIN = '/login';
  static const COIN = '/coin';
  static const PROFILE = '/profile';
  static const LANGUAGE = '/language';
  static const HOME = '/home';
  static const UPDATE_PROFILE = '/update_profile';

  static String getInitialRoute() {
    final isFirstRun = LocalStorage.getFirstRun();
    if (isFirstRun) {
      return AppRoutes.SPLASH;
    } else {
      if (LocalStorage.getUid().isNotEmpty) {
        return AppRoutes.HOME;
      }
      return AppRoutes.SPLASH;
    }
  }
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => AuthScreen(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(name: AppRoutes.COIN, page: () => CoinScreen()),
    GetPage(name: AppRoutes.HOME, page: () => HomeScreen()),
    GetPage(name: AppRoutes.PROFILE, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.LANGUAGE, page: () => LanguageSelectionScreen()),
    GetPage(name: AppRoutes.UPDATE_PROFILE, page: () => UpdateProfileScreen()),
  ];
}
