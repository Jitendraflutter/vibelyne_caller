import 'package:get/get.dart';
import 'package:voicly/controller/auth/login_controller.dart';
import 'package:voicly/controller/caller_controller.dart';
import 'package:voicly/features/auth/auth_screen.dart';
import 'package:voicly/features/blocked/blocked_user_screen.dart';
import 'package:voicly/features/call/call_screen.dart';
import 'package:voicly/features/coin/coin_screen.dart';
import 'package:voicly/features/history/call_history_screen.dart';
import 'package:voicly/features/home/home_screen.dart';
import 'package:voicly/features/language/language_screen.dart';
import 'package:voicly/features/profile/profile_screen.dart';
import 'package:voicly/features/profile/profile_update_screen.dart';
import 'package:voicly/features/splash/splash_screen.dart';
import 'package:voicly/features/support/support_screen.dart';

import '../../features/caller/become_caller_screen.dart';
import '../utils/local_storage.dart';
import 'binding.dart';

class AppRoutes {
  static const SPLASH = '/';
  static const ONBOARDING = '/onboarding';
  static const BOTTOM_BAR = '/bottom_bar';
  static const LOGIN = '/login';
  static const COIN = '/coin';
  static const PROFILE = '/profile';
  static const LANGUAGE = '/language';
  static const HOME = '/home';
  static const CALL_SCREEN = '/call_screen';
  static const UPDATE_PROFILE = '/update_profile';
  static const HISTORY = '/history_screen';
  static const BLOCKED_USER_SCREEN = '/blocked_users_screen';
  static const SUPPORT_SCREEN = '/support_screen';
  static const BECOME_CALLER_SCREEN = '/become_caller_screen';

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
    GetPage(name: AppRoutes.UPDATE_PROFILE, page: () => ProfileUpdateScreen()),
    GetPage(
      name: AppRoutes.CALL_SCREEN,
      page: () => CallView(),
      binding: BindingsBuilder.put(() => CallController(), permanent: true),
    ),

    GetPage(name: AppRoutes.HISTORY, page: () => CallHistoryScreen()),
    GetPage(
      name: AppRoutes.BLOCKED_USER_SCREEN,
      page: () => BlockedUsersScreen(),
    ),
    GetPage(name: AppRoutes.SUPPORT_SCREEN, page: () => SupportScreen()),
    GetPage(
      name: AppRoutes.BECOME_CALLER_SCREEN,
      page: () => BecomeCallerScreen(),
    ),
  ];
}
