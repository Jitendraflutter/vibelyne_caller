import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/core/constants/app_assets.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/core/utils/local_storage.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:voicly/networks/make_call.dart';
import 'package:voicly/widget/glass_container.dart';
import 'package:voicly/widget/screen_wrapper.dart';

import '../../core/constants/app_colors.dart';
import 'LogoutModal.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    return ScreenWrapper(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 60,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Get.back(),
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
            child: Obx(() {
              final user = authService.currentUser.value;

              // Fallback to LocalStorage if stream is still loading
              final name = user?.fullName ?? LocalStorage.getFirstName();
              final email = user?.email ?? LocalStorage.getEmail();
              final pic = user?.profilePic ?? LocalStorage.getProfileUrl();
              final completion = user?.completionText ?? "0%";
              return Column(
                children: [
                  const SizedBox(height: 20),
                  _buildProfileHeader(
                    name: name,
                    subtitle: email,
                    imageUrl: pic,
                    percent: user?.completionPercentage ?? 0.0,
                  ),
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
                          "$completion% Finished",
                          onPressed: () =>
                              Get.toNamed(AppRoutes.UPDATE_PROFILE),
                        ),

                        _profileTile(
                          CupertinoIcons.person_crop_circle_badge_checkmark,
                          "Make Call",
                          "call test",
                          onPressed: () {
                            makeTestCall();
                          },
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
                          onPressed: () => Get.toNamed(AppRoutes.LANGUAGE),
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
                          onPressed: () {},
                          "FAQs & Chat Support",
                        ),
                        _profileTile(
                          CupertinoIcons.square_arrow_right,
                          onPressed: () {
                            Get.bottomSheet(
                              LogoutModal(),
                              backgroundColor: Colors.transparent,
                              isScrollControlled:
                                  true, // Allows the modal to take required height
                            );
                          },
                          "Logout",
                          "",
                          isDestructive: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              );
            }),
          ),
        ],
      ),
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

  Widget _buildProfileHeader({
    required String name,
    required String subtitle,
    required String imageUrl,
    required double percent,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer Progress Ring
            SizedBox(
              width: 110,
              height: 110,
              child: CircularProgressIndicator(
                value: percent,
                strokeWidth: 4,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primaryPurple,
                ),
              ),
            ),
            // Profile Picture
            Hero(
              tag: "profile_pic",
              child: Container(
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white12,
                  backgroundImage: CachedNetworkImageProvider(
                    imageUrl.isEmpty ? AppAssets.iconProfile : imageUrl,
                  ),
                ),
              ),
            ),
            // Camera Icon Positioned
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.camera_fill,
                  size: 16,
                  color: AppColors.primaryPurple,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(color: AppColors.onBackground.withOpacity(0.6)),
        ),
      ],
    );
  }
}
