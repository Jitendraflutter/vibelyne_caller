// lib/data/repositories/user_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voicly/model/user_model.dart';
import 'package:core/core.dart';

class UserRepository extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Logic to save/update user
  Future<void> saveUser(UserModel user) async {
    try {
      await _db
          .collection('users')
          .doc(user.uid)
          .set(user.toMap(), SetOptions(merge: true));
    } catch (e) {
      Get.snackbar("Error", "Failed to save user: $e");
    }
  }

  // Real-time stream for user profile
  Stream<UserModel> watchUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((doc) {
      return UserModel.fromFirestore(doc);
    });
  }

  // Fetch all active callers
  Future<List<UserModel>> getActiveCallers() async {
    QuerySnapshot snapshot = await _db
        .collection('users')
        .where('isActive', isEqualTo: true)
        .get();
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  Future<void> createUserIfNotExist(UserModel user) async {
    try {
      // 1. Reference to the specific user document
      DocumentReference userRef = _db.collection('users').doc(user.uid);

      // 2. Fetch the document
      DocumentSnapshot doc = await userRef.get();

      // 3. Check for existence
      if (!doc.exists) {
        // Document does not exist - this is a FIRST TIME login
        await userRef.set(user.toMap());

        debugPrint("✅ New user record created for: ${user.email}");
        Get.snackbar(
          "Welcome!",
          "Your account has been created successfully.",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Document exists - returning user
        debugPrint(
          "ℹ️ User ${user.uid} already exists. Skipping document creation.",
        );

        // Optional: Update only the 'isActive' status if needed
        // await userRef.update({'isActive': true});
      }
    } catch (e) {
      debugPrint("❌ Error in createUserIfNotExist: $e");
      errorSnack("Could not verify user data.");
    }
  }

  // Helper method to update specific fields later (like points or bio)
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }
}
