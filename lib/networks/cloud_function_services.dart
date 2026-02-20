import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
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

  Future<Map<String, dynamic>?> createRazorpayOrder({
    required num amount,
    required String uid,
  }) async {
    try {
      // 1. Point to your specific Cloud Function
      final callable = _functions.httpsCallable('createRazorpayOrder');

      // 2. Execute the call with the parameters
      final response = await callable.call({'amount': amount, 'uid': uid});

      // 3. Safely cast the response data to a Dart Map
      return Map<String, dynamic>.from(response.data);
    } catch (e) {
      print("🚨 Error calling createRazorpayOrder: $e");
      return null;
    }
  }

  /// Returns [true] if successful, [false] if low balance/error.
  Future<bool> deductCallPoints({
    required String channelId,
    required String callerUid, // The User (Payer)
    required String receiverUid, // The Caller (Earner)
    required String callerName,
    required String callerAvatar,
    required String receiverName,
    required String receiverAvatar,
  }) async {
    try {
      final response = await _functions.httpsCallable('deductCallPoints').call({
        'channelId': channelId,
        'callerUid': callerUid,
        'receiverUid': receiverUid,
        'callerName': callerName,
        'callerAvatar': callerAvatar,
        'receiverName': receiverName,
        'receiverAvatar': receiverAvatar,
      });

      // Check the 'success' field from your Node.js response
      if (response.data['success'] == true) {
        debugPrint("✅ Deduction Successful: 9 Points");
        return true;
      } else {
        debugPrint("⚠️ Deduction Failed: ${response.data['message']}");
        return false;
      }
    } catch (e) {
      debugPrint("❌ Deduction Error: $e");
      return false; // Fail safe
    }
  }

  Future<void> updateCallStatus({
    required String channelId,
    required String status,
    String? otherUserToken,
  }) async {
    try {
      await _functions.httpsCallable('updateCallStatus').call({
        'channelId': channelId,
        'status': status,
        'otherUserToken': otherUserToken,
      });
      debugPrint("✅ Status updated to: $status");
    } catch (e) {
      debugPrint("❌ Error updating status: $e");
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
    debugPrint("❌ CloudFunctionService Error [$functionName]: $error");
    Get.snackbar("Server Error", "Something went wrong with $functionName");
  }
}
