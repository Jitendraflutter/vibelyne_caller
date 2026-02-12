import 'package:cloud_firestore/cloud_firestore.dart';

class CallerModel {
  final String uid;
  final String fullName;
  final String email;
  final String profilePic;
  final String? gender;
  final String? mobileNo;
  final List<String>? interests;
  final DateTime? dob;
  final String? bio;
  final String? fcmToken;
  final bool? isOnline;

  CallerModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.profilePic,
    this.gender,
    this.dob,
    this.interests,
    this.mobileNo,
    this.fcmToken,
    this.bio = "",
    this.isOnline = false,
  });

  factory CallerModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CallerModel(
      uid: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      profilePic: data['profilePic'] ?? '',
      gender: data['gender'],
      mobileNo: data['mobileNo'],
      fcmToken: data['fcmToken'],
      isOnline: data['isOnline'] ?? false,
      interests: data['interests'] != null
          ? List<String>.from(data['interests'])
          : [],
      dob: data['dob'] != null ? (data['dob'] as Timestamp).toDate() : null,
      bio: data['bio'] ?? '',
    );
  }
}
