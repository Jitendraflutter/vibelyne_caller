import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/features/auth/widget/phone_input.dart';
import 'package:voicly/widget/screen_wrapper.dart';

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
      child: PhoneInputScreen(onNext: () => Get.offAndToNamed(AppRoutes.HOME)),
    );
  }
}
