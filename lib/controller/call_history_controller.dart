import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../features/history/model/call_history_model.dart';

class CallHistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<CallHistoryModel> callLogs = <CallHistoryModel>[].obs;
  RxBool isInitialLoading = true.obs;

  String get currentUserId => _auth.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    if (currentUserId.isNotEmpty) {
      _bindCallLogs();
    }
  }

  void _bindCallLogs() {
    callLogs.bindStream(
      _firestore
          .collection('call_history')
          .where(Filter.or(
        Filter('callerUid', isEqualTo: currentUserId),
        Filter('receiverUid', isEqualTo: currentUserId),
      ))
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        isInitialLoading.value = false;
        return snapshot.docs.map((doc) => CallHistoryModel.fromFirestore(doc)).toList();
      }),
    );
  }

  Future<void> deleteCallLog(String historyId) async {
    await _firestore.collection('call_history').doc(historyId).delete();
  }
}