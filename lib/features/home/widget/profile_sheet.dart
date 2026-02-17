import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core/core.dart';
import '../../../model/caller_model.dart';
import 'package:voicly/core/constant/app_assets.dart';


class ProfileSheet extends StatelessWidget {
  final CallerModel callerModel;
  const ProfileSheet({super.key, required this.callerModel});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Stack(
            alignment: Alignment.center,
            children: [
              // 🔥 center drag line
              Positioned(
                top: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              // ❌ close button right side
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.primaryLite,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryLite.withValues(
                      alpha: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
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
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Helpers.ageFormatter(callerModel.dob.toString()),
                      style: TextStyle(color: AppColors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Bio Section
          if (callerModel.bio != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueAccent.withOpacity(0.1)),
              ),
              child: Text(
                callerModel.bio ?? AppStrings.voiclyBio,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 15,
                  color: AppColors.grey,
                ),
              ),
            ),

          const SizedBox(height: 24),

          // Communication Actions
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Video Call',
                  onPressed: () {
                    successSnack(AppStrings.appStatus);
                  },
                  icon: Icons.videocam_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  text: "Audio Call",
                  onPressed: () {
                    successSnack(AppStrings.appStatus);
                  },
                  icon: Icons.call_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Secondary Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.report_gmailerrorred_rounded,
                  color: Colors.redAccent,
                  size: 20,
                ),
                label: const Text(
                  "Report User",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_rounded,
                  color: Colors.blueGrey,
                  size: 20,
                ),
                label: const Text(
                  "Share Profile",
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
