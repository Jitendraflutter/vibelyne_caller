import 'package:flutter/material.dart';
import 'package:voicly/features/auth/widget/phone_input.dart';

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
    );
  }
}
