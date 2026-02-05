import 'package:flutter/material.dart';
import 'package:voicly/features/auth/widget/phone_input.dart';
<<<<<<< Updated upstream
import 'package:voicly/features/auth/profile_setup_screen.dart';
import 'package:voicly/features/home/home_screen.dart';
import 'package:voicly/widget/screen_wrapper.dart';
=======

>>>>>>> Stashed changes
import '../../core/constants/app_colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return ScreenWrapper(
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PhoneInputScreen(onNext: _nextPage),
          OTPScreen(onNext: _nextPage),
          ProfileSetupScreen(
            onComplete: () => AppRoute.pushAndRemoveAll(HomeScreen()),
          ),
        ],
      ),
=======
    return Scaffold(
      backgroundColor: AppColors.background,
      body: PhoneInputScreen(onNext: _nextPage),

      // PageView(
      //   controller: _pageController,
      //   physics: const NeverScrollableScrollPhysics(),
      //   children: [
      //
      //     // OTPScreen(onNext: _nextPage),
      //     // ProfileSetupScreen(
      //     //   onComplete: () => AppRoute.pushAndRemoveAll(HomeScreen()),
      //     // ),
      //   ],
      // ),
>>>>>>> Stashed changes
    );
  }
}
