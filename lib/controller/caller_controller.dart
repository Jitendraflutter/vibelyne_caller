import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:voicly/core/route/routes.dart';

import 'caller_overlay_controller.dart';

class CallController extends GetxController {
  var callStatus = "Dialing...".obs;
  var callDuration = 0.obs; // In seconds
  var isMuted = false.obs;
  var isSpeaker = false.obs;
  late RtcEngine _engine;
  var myVolume = 0.obs;
  var remoteVolume = 0.obs;
  int agoraRemoteUserId = 0;
  Timer? _timer;
  final CallOverlayController overlayController =
      Get.find<CallOverlayController>();
  final String channelId = Get.arguments['channel_id'];
  final String rtcToken = Get.arguments['rtc_token'];
  final String callerName = Get.arguments['caller_name'];
  final String callerUid = Get.arguments['caller_uid'] ?? "";
  final String callerAvatar = Get.arguments['caller_avatar'] ?? "";
  final String receiverToken = Get.arguments['receiver_token'] ?? "";
  final bool isReceiver = Get.arguments['is_receiver'] ?? false;

  @override
  void onInit() {
    super.onInit();
    _startRingtone();
    _initAgora();
    _listenToCallStatus();
  }

  void _startRingtone() {
    // If you are calling someone, play the 'dialing' tone
    // If you are receiving, the system already handled the 'ringing' tone
    if (!isReceiver) {
      FlutterRingtonePlayer().play(
        android: AndroidSounds.ringtone,
        ios: IosSounds.electronic,
        looping: true,
        volume: 0.5,
      );
    }
  }

  Future<void> _initAgora() async {
    // 1. Request Permissions

    // 2. Initialize Engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId:
            "26b2a0b4c5fa4595b6c1285f34b4a4eb", // Best practice: Get from your CloudFunctionService
        channelProfile: ChannelProfileType.channelProfileCommunication,
        audioScenario: AudioScenarioType.audioScenarioMeeting,
      ),
    );

    // 3. Set Event Handlers
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("Successfully joined channel: ${connection.channelId}");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          FlutterCallkitIncoming.setCallConnected(channelId);
          agoraRemoteUserId = remoteUid;
          FlutterRingtonePlayer().stop(); // Stop the dialing tone
          callStatus.value = "Connected";
          _startTimer();
        },
        onAudioVolumeIndication:
            (connection, speakers, speakerNumber, totalVolume) {
              for (var speaker in speakers) {
                if (speaker.uid == 0) {
                  myVolume.value = speaker.volume ?? 0;
                } else if (speaker.uid == agoraRemoteUserId) {
                  remoteVolume.value = speaker.volume ?? 0;
                }
              }
            },
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              endCall(); // Other person hung up
            },
      ),
    );

    // 4. Join Channel
    await _engine.joinChannel(
      token: rtcToken,
      channelId: channelId,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callDuration.value++;
    });
  }

  String get formattedTime {
    int minutes = callDuration.value ~/ 60;
    int seconds = callDuration.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    _engine.muteLocalAudioStream(isMuted.value);
  }

  void toggleSpeaker() {
    isSpeaker.value = !isSpeaker.value;
    _engine.setEnableSpeakerphone(isSpeaker.value);
  }

  void _listenToCallStatus() {
    FirebaseFirestore.instance
        .collection('calls')
        .doc(channelId)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists) {
            String status = snapshot.data()?['status'] ?? "";
            if (status == "end_call") {
              FlutterRingtonePlayer().stop();
              callStatus.value = "Call Declined";
              Future.delayed(const Duration(milliseconds: 200), () {
                endCall();
              });
            }
          }
        });
  }

  void endCall() async {
    overlayController.isMinimized.value = false;
    _timer?.cancel();
    FlutterRingtonePlayer().stop();
    await FlutterCallkitIncoming.endAllCalls();
    Get.delete<CallController>(force: true);
    if (Get.currentRoute == AppRoutes.CALL_SCREEN) {
      Get.back(result: "end_call");
    }
    await _engine.leaveChannel();
    await _engine.release();
    Get.back();
  }

  void returnToCallScreen() {
    overlayController.isMinimized.value = false;
    Get.toNamed(
      AppRoutes.CALL_SCREEN,
      arguments: {
        'channel_id': channelId,
        'rtc_token': rtcToken,
        'caller_name': callerName,
        'caller_uid': callerUid,
        'caller_avatar': callerAvatar,
      },
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    _engine.release();
    super.onClose();
  }
}
