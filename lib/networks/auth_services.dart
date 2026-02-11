// lib/logic/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:voicly/networks/user_service.dart';

import '../model/user_model.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Dependency Injection: Finding the repository service
  final UserRepository _userRepo = Get.find<UserRepository>();

  Rxn<UserModel> currentUser = Rxn<UserModel>();

  // Initialize the auth listener
  Future<AuthService> init() async {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        currentUser.bindStream(_userRepo.watchUser(user.uid));
      } else {
        currentUser.value = null;
      }
    });
    return this;
  }

  // Simple getter for current points
  int get currentPoints => currentUser.value?.points ?? 0;

  // Method to manage points via the service
  Future<void> updatePoints(int newPoints) async {
    if (currentUser.value != null) {
      await _userRepo.saveUser(currentUser.value!.copyWith(points: newPoints));
    }
  }
}
