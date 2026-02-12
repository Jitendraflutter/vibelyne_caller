import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/controller/caller_controller.dart';

class CallView extends GetView<CallController> {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CircleAvatar(radius: 60, child: Icon(Icons.person, size: 60)),
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
                      onTap: controller.endCall,
                      size: 70,
                    ),
                    _iconButton(
                      icon: Icons.volume_up,
                      color: Colors.white24,
                      onTap: () {}, // Add speaker toggle logic
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    double size = 56,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}
