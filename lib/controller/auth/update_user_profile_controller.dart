import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/core/utils/show_custom_notification.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:voicly/networks/user_service.dart';

class UpdateProfileController extends GetxController {
  final UserRepository _userRepo = Get.find<UserRepository>();
  final authService = Get.find<AuthService>();

  late TextEditingController nameController;
  late TextEditingController bioController;
  var selectedGender = "".obs;
  var selectedDob = Rxn<DateTime>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final user = authService.currentUser.value;
    nameController = .new(text: user?.fullName);
    bioController = .new(text: user?.bio);
    selectedGender.value = user?.gender ?? "";
    selectedDob.value = user?.dob;
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      final uid = authService.currentUser.value!.uid;

      await _userRepo.updateUserData(uid, {
        'fullName': nameController.text.trim(),
        'bio': bioController.text.trim(),
        'gender': selectedGender.value,
        'dob': selectedDob.value != null
            ? Timestamp.fromDate(selectedDob.value!)
            : null,
      });

      Get.back(); // Close modal
      successSnack("Profile updated successfully");
    } catch (e) {
      errorSnack(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
