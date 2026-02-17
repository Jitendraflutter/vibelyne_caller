import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PulsingAvatar extends StatelessWidget {
  final String imageUrl;
  final RxInt volumeLevel; // Pass the observable volume (0 - 255)
  final double baseSize;

  const PulsingAvatar({
    super.key,
    required this.imageUrl,
    required this.volumeLevel,
    this.baseSize = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double normalizedVolume = (volumeLevel.value / 255.0).clamp(0.0, 1.0);

      double glowSpread = normalizedVolume * 55.0;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250), // Matches Agora's interval
        curve: Curves.easeOut,
        width: baseSize + glowSpread,
        height: baseSize + glowSpread,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green.withOpacity(
            normalizedVolume * 0.5,
          ), // Fades in when loud
        ),
        alignment: Alignment.center,
        child: Container(
          width: baseSize,
          height: baseSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 2),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                imageUrl,
              ), // Use your avatar URL here
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });
  }
}
