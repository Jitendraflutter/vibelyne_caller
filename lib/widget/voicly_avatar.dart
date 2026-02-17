import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class VoiclyAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;
  final double radius;
  final bool showStatus;
  final void Function()? onTap;
  final double borderWidth;

  const VoiclyAvatar({
    super.key,
    required this.imageUrl,
    this.isOnline = false,
    this.radius = 40,
    this.showStatus = true,
    this.onTap,
    this.borderWidth = 2.0,


  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 🔥 Gradient border avatar
          Container(
            padding:  EdgeInsets.all(borderWidth),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryButtonGradient,
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundColor: AppColors.primaryPeachShade,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),

          // 🟢 Online/offline status
          if (showStatus)
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: radius * 0.35,
                height: radius * 0.35,
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.success : Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
