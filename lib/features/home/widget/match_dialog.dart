import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../controller/match_controller.dart';
import '../../../model/caller_model.dart';
import 'package:core/core.dart';


class MatchDialog {
  static void show(List<CallerModel> candidates) {
    // Initialize the logic controller specifically for this dialog instance
    final controller = Get.put(MatchController(candidates));

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Obx(() {
          final user = controller.currentDisplayUser.value;
          final cycling = controller.isCycling.value;

          if (user == null) return const SizedBox.shrink();

          return AnimatedScale(
            duration: const Duration(milliseconds: 400),
            scale: cycling ? 0.95 : 1.05,
            curve: Curves.elasticOut,
            child: GlassContainer(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cycling ? "SEARCHING..." : "FOUND A MATCH! ❤️",
                      style: const TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Avatar with status ring
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: cycling ? Colors.white24 : AppColors.success,
                          width: 4,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: CachedNetworkImageProvider(
                          user.profilePic,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (!cycling) ...[
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _actionBtn(
                            CupertinoIcons.phone_fill,
                            Colors.green,
                            () {
                              Get.back();
                              // Call logic here
                            },
                          ),
                          _actionBtn(
                            CupertinoIcons.videocam_fill,
                            AppColors.purpleDark,
                            () {
                              Get.back();
                              // Video logic here
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    ).then(
      (_) => Get.delete<MatchController>(),
    ); // Cleanup memory when dialog closes
  }

  static Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.5),
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}
