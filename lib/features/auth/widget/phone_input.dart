import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:voicly/controller/auth/login_controller.dart';
import 'package:voicly/core/constants/app_strings.dart';
import 'package:voicly/core/constants/app_svg.dart';

import 'base_layout.dart';

class PhoneInputScreen extends StatelessWidget {
  final VoidCallback onNext;
  const PhoneInputScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return BaseAuthLayout(
      title: "Welcome!",
      subtitle: "Enter your mobile number to get started",
      child: Column(
        children: [
          _buildSocialButton(
            text: AppStrings.signInWithGoogle,
            // Using a colorful Google icon asset is recommended for production
            icon: Icon(Icons.g_mobiledata_rounded, color: Colors.red, size: 28),
            onPressed: () async {
              try {
                context.loaderOverlay.show();
                await controller.signInWithGoogleFirebase();
              } finally {
                context.loaderOverlay.hide();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,

        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppSvg.google, width: 28, height: 28),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
