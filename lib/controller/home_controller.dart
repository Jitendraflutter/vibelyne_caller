import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voicly/controller/popup_controller.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/model/caller_model.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:voicly/networks/cloud_function_services.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final authService = Get.find<AuthService>();
  final popupController = Get.find<PopupController>();

  // Observable list of callers
  RxList<CallerModel> callers = <CallerModel>[].obs;
  final cloudService = Get.put(CloudFunctionService());
  final auth = Get.find<AuthService>();
  void startCall(CallerModel user) async {
    num currentPoints = auth.currentUser.value?.points ?? 0;

    if (currentPoints < 5) {
      popupController.showWelcomePopupWithDelay(seconds: 0, popupIndex: 1);
      return;
    }

    bool allowed = await _handlePermission();
    if (!allowed) return;
    String channelId = "call_${auth.currentUser.value?.uid ?? ""}_${user.uid}";
    Get.context?.loaderOverlay.show();
    final result = await cloudService.initiateCall(
      receiverToken: user.fcmToken ?? "",
      receiverUid: user.uid,
      callerAvatar: auth.currentUser.value?.profilePic ?? "",
      callerName: auth.currentUser.value?.fullName ?? "",
      channelId: channelId,
    );
    Get.context?.loaderOverlay.hide();

    CallKitParams params = CallKitParams(
      id: channelId, // Use the exact same channel ID so you can end it later
      nameCaller: user.fullName ?? "Unknown", // The person you are calling
      avatar: user.profilePic ?? "",
      handle: "Voicly Audio Call",
      type: 0, // 0 = Audio Call, 1 = Video Call
      extra: <String, dynamic>{'uid': user.uid},
      ios: IOSParams(
        handleType: 'generic',
        supportsVideo: false,
        audioSessionMode: 'voiceChat',
        audioSessionActive: true,
      ),
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa', // Your app's primary brand color
        actionColor: '#4CAF50',
        incomingCallNotificationChannelName: "Active Call",
      ),
    );

    // 🟢 2. Tell the OS: "I am starting an outgoing phone call!"
    // This creates the background service and prepares the OS notification tray.
    await FlutterCallkitIncoming.startCall(params);

    if (result != null && result['success']) {
      Get.toNamed(
        AppRoutes.CALL_SCREEN,
        arguments: {
          'rtc_token': result['rtcToken'],
          'channel_id': channelId,
          'caller_name': user.fullName,
          'caller_uid': user.uid,
          'caller_avatar': user.profilePic,
          'receiver_token': user.fcmToken,
          'is_receiver': false,
        },
      );
    }
  }

  Future<bool> _handlePermission() async {
    final status = await [Permission.microphone].request();
    final micStatus = status[Permission.microphone];

    if (micStatus == null || !micStatus.isGranted) {
      if (micStatus?.isPermanentlyDenied ?? false) {
        Get.snackbar(
          "Permission",
          "Mic permanently denied. Enable from settings",
        );
        await openAppSettings();
      } else {
        Get.snackbar("Permission", "Mic permission required for call");
      }
      return false;
    }

    return true;
  }

  @override
  void onInit() {
    super.onInit();
    callers.bindStream(
      _db
          .collection('callers')
          .where('isActive', isEqualTo: true) // Only show active callers
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => CallerModel.fromFirestore(doc))
                .toList(),
          ),
    );
  }
}
