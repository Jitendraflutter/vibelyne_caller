import 'package:flutter/material.dart';
<<<<<<< Updated upstream

import '../../core/constants/app_colors.dart';
import '../../widget/screen_wrapper.dart';
=======
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
>>>>>>> Stashed changes

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
<<<<<<< Updated upstream
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
=======
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
>>>>>>> Stashed changes
          children: [
            const SizedBox(height: 30),
            _buildProfileHeader(),
            const SizedBox(height: 40),
            _buildProfileOption(Icons.person_outline, "Edit Profile"),
            _buildProfileOption(Icons.account_balance_outlined, "Bank Details"),
            _buildProfileOption(Icons.security_outlined, "Privacy & Safety"),
            _buildProfileOption(Icons.help_outline, "Help Center"),
            const SizedBox(height: 20),
            _buildProfileOption(
              Icons.logout_rounded,
              "Logout",
              isDestructive: true,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

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
                backgroundColor: AppColors.dark,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryPeach,
              child: Icon(Icons.edit, size: 16, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Aksbyte",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "ID: VOIC-99283",
          style: TextStyle(color: AppColors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.redAccent : AppColors.primaryLavender,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.redAccent : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.grey,
          size: 20,
        ),
      ),
    );
  }
}
