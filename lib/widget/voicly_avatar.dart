import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';


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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(borderWidth),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryButtonGradient,
              ),
              child: CircleAvatar(
                radius: radius,
                backgroundColor: AppColors.primaryPeachShade,
                backgroundImage: CachedNetworkImageProvider(imageUrl),
              ),
            ),
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
      ),
    );
  }
}
