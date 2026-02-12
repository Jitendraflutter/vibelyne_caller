import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';

class CloudFunctionService extends GetxService {
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(
    region: 'asia-south1',
  );

  /// 1. Initiate Call & Generate Agora Token
  Future<Map<String, dynamic>?> initiateCall({
    required String receiverToken,
    required String receiverUid,
    required String callerName,
    required String callerAvatar,
    required String channelId,
  }) async {
    try {
      final response = await _functions
          .httpsCallable('sendCallNotification')
          .call({
            'token': receiverToken,
            'receiverUid': receiverUid,
            'callerName': callerName,
            'callerAvatar': callerAvatar,
            'channelId': channelId,
            'uuid': DateTime.now().millisecondsSinceEpoch.toString(),
          });
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      _handleError("initiateCall", e);
      return null;
    }
  }

  /// 2. Update Call Status (ringing, active, ended, cancelled)
  Future<bool> updateCallStatus(String channelId, String status) async {
    try {
      await _functions.httpsCallable('updateCallStatus').call({
        'channelId': channelId,
        'status': status,
      });
      return true;
    } catch (e) {
      _handleError("updateCallStatus", e);
      return false;
    }
  }

  /// 3. Send Global Push Notification
  Future<void> sendPush({
    required String token,
    required String title,
    required String body,
    Map<String, dynamic>? customData,
  }) async {
    try {
      await _functions.httpsCallable('sendGeneralNotification').call({
        'token': token,
        'title': title,
        'body': body,
        'customData': customData ?? {},
      });
    } catch (e) {
      _handleError("sendPush", e);
    }
  }

  void _handleError(String functionName, Object error) {
    print("❌ CloudFunctionService Error [$functionName]: $error");
    Get.snackbar("Server Error", "Something went wrong with $functionName");
  }
}
