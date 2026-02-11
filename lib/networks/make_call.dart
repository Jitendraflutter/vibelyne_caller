import 'package:cloud_functions/cloud_functions.dart';

Future<void> makeTestCall() async {
  try {
    print('🔔 Initiating call notification...');

    final HttpsCallable callable = FirebaseFunctions.instanceFor(
      region: 'us-central1',
    ).httpsCallable('sendCallNotification');

    final response = await callable.call({
      'token':
          'c_zYr-LRRuSfyTt9q-biL_:APA91bFmD5KxgIF6BUSPTPhBMRgS_xER4UmTMXojC76uiOZw6bcQnmJNE141AYH5UGDJJlQdWdyaMZudVZV4Zu1bgVRh2X35H_WrgBOIzE6xt3vweIvvByA',
      'callerName': 'Devan Kumar Verma',
      'uuid': 'call_uuid_${DateTime.now().millisecondsSinceEpoch}',
      'channelId': 'voicly_room_101',
    });

    print("✅ Success! Response: ${response.data}");
  } on FirebaseFunctionsException catch (e) {
    print("❌ Firebase Functions Error:");
    print("   Code: ${e.code}");
    print("   Message: ${e.message}");
    print("   Details: ${e.details}");
  } catch (e, stackTrace) {
    print("❌ General Error: $e");
    print("Stack trace: $stackTrace");
  }
}
