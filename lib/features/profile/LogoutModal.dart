import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/core/utils/local_storage.dart';
import 'package:core/core.dart';


class LogoutModal extends StatelessWidget {
  const LogoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.4, -0.6), // top glow
          radius: 1.5,
          colors: [
            AppColors.primaryPeachShade,
            Color(0xFF2B2F3A), // bluish dark mid
            Color(0xFF0D0F14), // deep black edges
          ],
          stops: [0.0, 0.45, 1.0],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content height
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Drag Handle
          Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          SizedBox(height: 30),

          // 2. Title
          Text(
            "Are you sure you want to logout from your account?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),

          SizedBox(height: 30),

          AppButton(
            text: 'Logout',
            icon: CupertinoIcons.square_arrow_right,
            onPressed: () {
              LocalStorage.clearLogInSession();
              GoogleSignIn.instance.disconnect();
              GoogleSignIn.instance.signOut();
              Get.offAllNamed(AppRoutes.LOGIN);
            },
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
