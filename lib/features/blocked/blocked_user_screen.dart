import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:voicly/core/constant/app_assets.dart';
import 'package:voicly/widget/screen_wrapper.dart';


class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      visibleAppBar: true,
      title: "Blocked Users",
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: 5, // Hardcoded value
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: GlassContainer(
            child: Row(
              children: [
                // Avatar Section
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(AppAssets.userUrl),
                  backgroundColor: AppColors.primaryPeach.withOpacity(0.1),
                ),
                const SizedBox(width: 16),

                // User Info Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blocked User',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.onBackground,
                          fontSize: 17,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Blocked on 12 Feb 2026",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.onBackground.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                // Unblock Action
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: AppColors.primaryPeach.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  onPressed: () {
                    // Logic to unblock
                  },
                  child: const Text(
                    "Unblock",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
