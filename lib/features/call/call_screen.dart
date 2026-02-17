import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/controller/caller_controller.dart';
import 'package:voicly/controller/caller_overlay_controller.dart';
import 'package:voicly/features/call/pulsing_avatar.dart';

import '../../networks/cloud_function_services.dart';

class CallView extends GetView<CallController> {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (result == "end_call") {
          return;
        }
        Get.find<CallOverlayController>().isMinimized.value = true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.deepPurple.shade900],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Caller Profile Pic
                SizedBox(
                  height: 170,
                  child: PulsingAvatar(
                    imageUrl: controller.callerAvatar,
                    volumeLevel: controller.remoteVolume,
                    baseSize: 130,
                  ),
                ),
                const SizedBox(height: 20),

                // Caller Name
                Text(
                  controller.callerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Dynamic Status / Timer
                Obx(
                  () => Text(
                    controller.callStatus.value == "Connected"
                        ? controller.formattedTime
                        : controller.callStatus.value,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),

                const Spacer(),

                // Control Bar
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => _iconButton(
                          icon: controller.isMuted.value
                              ? Icons.mic_off
                              : Icons.mic,
                          color: Colors.white24,
                          onTap: controller.toggleMute,
                        ),
                      ),
                      _iconButton(
                        icon: Icons.call_end,
                        color: Colors.red,
                        onTap: () {
                          Get.find<CloudFunctionService>().updateCallStatus(
                            channelId: controller.channelId,
                            status: "end_call_by_user",
                            otherUserToken: controller.receiverToken,
                          );
                          controller.endCall();
                        },
                        size: 70,
                      ),
                      Obx(() {
                        return _iconButton(
                          icon: Icons.volume_up,
                          color: controller.isSpeaker.isTrue
                              ? Colors.white
                              : Colors.white24,
                          onTap: controller.toggleSpeaker,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required Color color,
    Color? iconColor = Colors.white,
    required VoidCallback onTap,
    double size = 56,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }
}
