import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/core/utils/local_storage.dart';

class LogoutModal extends StatelessWidget {
  const LogoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
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
              color: Colors.black,
            ),
          ),

          SizedBox(height: 30),

          // 4. Logout Button (Solid Purple)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),

              onPressed: () {
                LocalStorage.clearLogInSession();
                GoogleSignIn.instance.disconnect();
                GoogleSignIn.instance.signOut();
                Get.offAllNamed(AppRoutes.LOGIN);
              },
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ),

          SizedBox(height: 15),

          // 5. Cancel Button (Light Purple)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),

              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.cancel, color: Colors.grey),
              label: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
          ),

          // Safe Area padding for bottom devices
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
