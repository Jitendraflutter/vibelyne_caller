import 'package:cloud_firestore/cloud_firestore.dart';

class CallHistoryModel {
  final String? callerAvatar;
  final String? callerName;
  final String? callerUid;
  final String? channelId;
  final int? durationSeconds;
  final String? historyId;
  final String? receiverAvatar;
  final String? receiverName;
  final String? receiverUid;
  final String? status;
  final DateTime? timestamp;
  final int? totalDeducted;

  CallHistoryModel({
    this.callerAvatar,
    this.callerName,
    this.callerUid,
    this.channelId,
    this.durationSeconds,
    this.historyId,
    this.receiverAvatar,
    this.receiverName,
    this.receiverUid,
    this.status,
    this.timestamp,
    this.totalDeducted,
  });

  factory CallHistoryModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CallHistoryModel(
      callerAvatar: data['callerAvatar'],
      callerName: data['callerName'],
      callerUid: data['callerUid'],
      channelId: data['channelId'],
      durationSeconds: data['durationSeconds']?.toInt(),
      historyId: data['historyId'],
      receiverAvatar: data['receiverAvatar'],
      receiverName: data['receiverName'],
      receiverUid: data['receiverUid'],
      status: data['status'],
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      totalDeducted: data['totalDeducted']?.toInt(),
    );
  }
}