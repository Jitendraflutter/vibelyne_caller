import 'dart:ui';
import 'package:core/widget/widget_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core/core.dart';
import 'package:voicly/widget/screen_wrapper.dart';
import '../../../model/caller_model.dart';
import 'package:voicly/core/constant/app_assets.dart';

class ProfileSheet extends StatelessWidget {
  final CallerModel callerModel;
  const ProfileSheet({super.key, required this.callerModel});

  @override
  Widget build(BuildContext context) {
    return WidgetWrapper(
      // Your custom gradient wrapper
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildProfileInfo(),
              const SizedBox(height: 24),
              if (callerModel.bio != null) _buildBioSection(),
              const SizedBox(height: 24),
              _buildCallButtons(),
              _buildFooterActions(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Methods to keep the build method clean ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 48), // Spacer to balance the close button
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close_rounded, color: AppColors.primaryLite),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryLite.withOpacity(0.2),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      children: [
        VoiclyAvatar(
          imageUrl: callerModel.profilePic.isNotEmpty
              ? callerModel.profilePic
              : AppAssets.userUrl,
          isOnline: callerModel.isOnline ?? false,
          radius: 40,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                callerModel.fullName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onBackground,
                ),
              ),
              Text(
                Helpers.ageFormatter(callerModel.dob.toString()),
                style: TextStyle(color: AppColors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        callerModel.bio ?? AppStrings.voiclyBio,
        style: TextStyle(color: AppColors.grey),
      ),
    );
  }

  Widget _buildCallButtons() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: 'Video',
            onPressed: () {},
            icon: Icons.videocam_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            text: "Audio",
            onPressed: () {},
            icon: Icons.call_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.report, color: Colors.redAccent),
          label: const Text(
            "Report",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.share, color: Colors.blueGrey),
          label: const Text("Share", style: TextStyle(color: Colors.blueGrey)),
        ),
      ],
    );
  }
}
