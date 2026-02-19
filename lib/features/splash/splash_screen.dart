import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/controller/splash_controller.dart';
import 'package:voicly/core/constant/app_assets.dart';
import 'package:core/core.dart';
import 'package:voicly/widget/screen_wrapper.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: -50, right: -50, child: _decorativeCircle(200)),
            Positioned(bottom: -20, left: -30, child: _decorativeCircle(150)),

            ScaleTransition(
              scale: controller.animation,
              child: FadeTransition(
                opacity: controller.animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppAssets.logo, height: 120, width: 120),
                    const SizedBox(height: 24),

                    // const Text(
                    //   AppStrings.appName,
                    //   style: TextStyle(
                    //     color: AppColors.primaryPeach,
                    //     fontSize: 28,
                    //     fontWeight: FontWeight.bold,
                    //     letterSpacing: 4,
                    //   ),
                    // ),
                    Image.asset(
                      AppAssets.appName,
                      height: 40,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      AppStrings.tagline1,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              bottom: 50,
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _decorativeCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/controller/splash_controller.dart';
import 'package:voicly/core/constants/app_assets.dart';
import 'package:voicly/core/constants/app_colors.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPeach,
              AppColors.primaryLavender,
              AppColors.primaryPurple,
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: -50, right: -50, child: _decorativeCircle(200)),
            Positioned(bottom: -20, left: -30, child: _decorativeCircle(150)),

            ScaleTransition(
              scale: controller.animation,
              child: FadeTransition(
                opacity: controller.animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppAssets.logo, height: 120, width: 120),
                    const SizedBox(height: 24),
                    const Text(
                      "Voicly",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Because Every Voice Has a Story",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              bottom: 50,
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                  strokeWidth: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _decorativeCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
    );
  }
}
*/
