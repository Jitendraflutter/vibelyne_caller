import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voicly/widget/glass_container.dart';
import 'package:voicly/widget/screen_wrapper.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../widget/call_button.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      visibleAppBar: true,
      title: "Call History",
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: 12,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: GlassContainer(
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(AppAssets.userUrl),
                      backgroundColor: AppColors.primaryPeach.withOpacity(0.1),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anonymous User',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.onBackground,
                          fontSize: 17,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.call_made,
                            size: 14,
                            color: Color(0xFF4CAF50),
                          ),
                          const SizedBox(width: 6),

                          Text(
                            "Today, 02:30 PM",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.onBackground.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      Text(
                        "Duration: 12m 45s",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryPeach,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    CallButton(
                      icon: CupertinoIcons.phone_fill,
                      color: AppColors.onPrimary,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    CallButton(
                      icon: CupertinoIcons.videocam_fill,
                      color: AppColors.onPrimary,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
