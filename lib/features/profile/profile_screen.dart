import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voicly/core/constants/app_assets.dart';
import 'package:voicly/core/route/app_route.dart';
import 'package:voicly/features/language/language_screen.dart';
import 'package:voicly/widget/glass_container.dart';
import 'package:voicly/widget/screen_wrapper.dart';
import '../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 60,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => AppRoute.pop(),
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: FlexibleSpaceBar(
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      color: AppColors.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  centerTitle: true,
                  // background: Container(color: Colors.white.withOpacity(0.2)),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildProfileHeader(),
                const SizedBox(height: 30),

                // Section 1: Account
                _buildSectionTitle("Account Management"),
                const SizedBox(height: 5),
                GlassContainer(
                  child: Column(
                    children: [
                      _profileTile(
                        CupertinoIcons.person_crop_circle_badge_checkmark,
                        "Complete Profile",
                        "90% Finished",
                      ),
                      _profileTile(
                        CupertinoIcons.shield_fill,
                        "Account Settings",
                        "Security & Passwords",
                      ),
                      _profileTile(
                        CupertinoIcons.slash_circle,
                        "Blocked Users",
                        "Manage restrictions",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                _buildSectionTitle("Preferences"),
                const SizedBox(height: 5),

                GlassContainer(
                  child: Column(
                    children: [
                      _profileTile(
                        CupertinoIcons.bell_fill,
                        "Notifications",
                        "Sounds & Alerts",
                      ),
                      _profileTile(
                        CupertinoIcons.eye_slash_fill,
                        "Privacy Policy",
                        "Data usage & safety",
                      ),
                      _profileTile(
                        onPressed: () => AppRoute.push(LanguageSelectionScreen()),
                        CupertinoIcons.gear_alt,
                        "Language",
                        "App language settings",
                      ),
                      _profileTile(
                        CupertinoIcons.doc_text_fill,
                        "Terms & Conditions",
                        "Legal agreements",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),
                _buildSectionTitle("Support"),
                const SizedBox(height: 5),

                GlassContainer(
                  child: Column(
                    children: [
                      _profileTile(
                        CupertinoIcons.question_circle_fill,
                        "Help Center",
                        "FAQs & Chat Support",
                      ),
                      _profileTile(
                        CupertinoIcons.square_arrow_right,
                        "Logout",
                        null,
                        isDestructive: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- PROFILE HEADER WITH GLOW ---
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.logoGradient,
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(AppAssets.iconProfile),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.camera_fill,
                size: 18,
                color: AppColors.primaryPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          "Aksbyte",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        Text(
          "@flutter_dev_3yoe",
          style: TextStyle(color: AppColors.onBackground.withOpacity(0.6)),
        ),
      ],
    );
  }

  // --- GLASS GROUP CONTAINER ---
  Widget _buildGlassGroup(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(children: children),
          ),
        ),
      ),
    );
  }

  // --- INDIVIDUAL TILE ---
  Widget _profileTile(
    IconData icon,
    String title,
    String? subtitle, {
    bool isDestructive = false,
    void Function()? onPressed,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    (isDestructive ? AppColors.error : AppColors.primaryPurple)
                        .withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isDestructive
                    ? AppColors.error
                    : AppColors.primaryPurple,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDestructive
                          ? AppColors.error
                          : AppColors.onBackground,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.onBackground.withOpacity(0.5),
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_forward,
              size: 16,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
