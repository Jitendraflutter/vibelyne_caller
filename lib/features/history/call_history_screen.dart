import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/call_history_controller.dart';
import 'model/call_history_model.dart';
import 'package:core/core.dart';
import 'package:voicly/core/constant/app_assets.dart';



class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CallHistoryController());

    return ScreenWrapper(
      visibleAppBar: true,
      title: "Call History",
      child: Obx(() {
        if (controller.isInitialLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryPeach),
          );
        }
        if (controller.callLogs.isEmpty) {
          return const Center(
            child: Text("No calls yet", style: TextStyle(color: Colors.white)),
          );
        }

        return ListView.builder(
          itemCount: controller.callLogs.length,
          itemBuilder: (context, index) {
            final CallHistoryModel call = controller.callLogs[index];

            final bool isOutgoing = call.callerUid == controller.currentUserId;
            final String displayName =
                (isOutgoing ? call.receiverName : call.callerName) ?? "Unknown";
            final String displayAvatar =
                (isOutgoing ? call.receiverAvatar : call.callerAvatar) ??
                AppAssets.userUrl;
            final String formattedTime = call.timestamp != null
                ? DateFormat('MMM dd, hh:mm a').format(call.timestamp!)
                : "Unknown Time";

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: Dismissible(
                key: Key(call.historyId ?? index.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => controller.deleteCallLog(call.historyId!),
                background: _buildDeleteBackground(),
                child: GlassContainer(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(displayAvatar),
                        backgroundColor: AppColors.primaryPeach.withOpacity(
                          0.1,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.onBackground,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.call_made,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.onBackground.withOpacity(
                                      0.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Duration: ${call.durationSeconds ?? 0}s",
                              style: const TextStyle(
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
            );
          },
        );
      }),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 25),
      child: const Icon(CupertinoIcons.delete, color: Colors.white, size: 24),
    );
  }
}
