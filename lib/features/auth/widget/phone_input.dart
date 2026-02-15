import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:voicly/controller/auth/login_controller.dart';
import 'package:voicly/core/constants/app_assets.dart';
import 'package:voicly/core/constants/app_strings.dart';
import 'package:voicly/core/constants/app_svg.dart';
import 'package:voicly/core/utils/helpers.dart';
import '../../../core/constants/app_colors.dart';
import '../../coin/coin_screen.dart';
import 'base_layout.dart';

class PhoneInputScreen extends StatelessWidget {
  final VoidCallback onNext;
  const PhoneInputScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return BaseAuthLayout(
      title: "Let's Get Started!", // More energetic title
      subtitle: "Join our community and start your journey with just one tap.",
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Added a decorative illustration area to make the screen look full
          Container(
            height: 180,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              AppAssets
                  .logo, // Or a specific "Welcome/Auth" illustration if you have one
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 40),

          // Enhanced description text
          const Text(
            "Experience seamless access to your account. No passwords, no waiting—just secure and fast authentication.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.grey, height: 1.5),
          ),

          const SizedBox(height: 40),

          _buildSocialButton(
            text: AppStrings.signInWithGoogle,
            onPressed: () async {
              try {
                context.loaderOverlay.show();
                await controller.signInWithGoogleFirebase();
              } finally {
                context.loaderOverlay.hide();
              }
            },
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "By continuing, you agree to our ",
                style: TextStyle(color: AppColors.grey, fontSize: 12),
                children: [
                  TextSpan(
                    text: "Terms of Service",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPeach,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Helpers.launchURL(AppStrings.termsOfService),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPeach,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Helpers.launchURL(AppStrings.privacyPolicy),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56, // Slightly taller for better touch target
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            gradient: AppColors.logoGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppSvg.google, width: 24, height: 24),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
