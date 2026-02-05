import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String profilePic;
  final String? gender;
  final DateTime? dob;
  final String? bio;
  final int points;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.gender,
    this.dob,
    this.bio = "",
    this.points = 0,
    this.isActive = true,
  });

  // Convert Firestore Document to Model
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      profilePic: data['profilePic'] ?? '',
      gender: data['gender'] ?? '',
      dob: data['dob'] != null ? (data['dob'] as Timestamp).toDate() : null,
      bio: data['bio'] ?? '',
      points: data['points'] ?? 0,
      isActive: data['isActive'] ?? true,
    );
  }

  // Convert Model to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'profilePic': profilePic,
      'gender': gender,
      'dob': dob != null ? Timestamp.fromDate(dob!) : null,
      'bio': bio,
      'points': points,
      'isActive': isActive,
    };
  }

  UserModel copyWith({int? points, String? bio, bool? isActive}) {
    return UserModel(
      uid: uid,
      fullName: fullName,
      email: email,
      profilePic: profilePic,
      gender: gender,
      dob: dob,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      isActive: isActive ?? this.isActive,
    );
  }

  double get completionPercentage {
    int totalFields = 6;
    int completedFields = 0;

    if (fullName.isNotEmpty) completedFields++;
    if (email.isNotEmpty) completedFields++;
    if (profilePic.isNotEmpty) completedFields++;
    if ((gender ?? "").isNotEmpty) completedFields++;
    if (dob != null) completedFields++;
    if ((bio ?? "").isNotEmpty) completedFields++;

    return (completedFields /
        totalFields); // Returns a value between 0.0 and 1.0
  }

  // To show as a string like "60%"
  String get completionText => "${(completionPercentage * 100).toInt()}%";
}
