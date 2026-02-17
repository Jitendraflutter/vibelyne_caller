import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/controller/caller_controller.dart';
import 'package:voicly/controller/caller_overlay_controller.dart';

class MiniCallOverlay extends StatelessWidget {
  const MiniCallOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final overlayState = Get.find<CallOverlayController>();

    return Material(
      color: Colors.transparent,
      child: Obx(() {
        if (!overlayState.isMinimized.value) {
          return const SizedBox.shrink();
        }
        final controller = Get.find<CallController>();

        return GestureDetector(
          onTap: () => controller.returnToCallScreen(),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.mic, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "In Call: ${controller.callerName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // 🟢 This will now tick live because it's inside the Obx!
                      Text(
                        controller.formattedTime,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    controller.isMuted.value ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                  ),
                  onPressed: () => controller.toggleMute(),
                ),
                IconButton(
                  icon: const Icon(Icons.call_end, color: Colors.red),
                  onPressed: () => controller.endCall(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
