import 'package:flutter/material.dart';
import 'package:voicly/core/route/app_route.dart';
import 'package:voicly/features/auth/widget/phone_input.dart';
import 'package:voicly/features/auth/profile_setup_screen.dart';
import 'package:voicly/features/home/home_screen.dart';
import 'package:voicly/widget/screen_wrapper.dart';
import '../../core/constants/app_colors.dart';
import 'otp_screen.dart';

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
    );
  }
}
