import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/core/utils/local_storage.dart';
import 'package:voicly/model/user_model.dart';
import 'package:voicly/networks/user_service.dart';

class LoginController extends GetxController {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;
  final formKey = GlobalKey<FormState>();
  final UserRepository _userRepo = Get.find<UserRepository>();
  var isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  @override
  void onReady() {
    _initializeGoogleSignIn();
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {}
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount> loginWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    try {
      final GoogleSignInAccount account = await _googleSignIn.authenticate();
      return account;
    } on GoogleSignInException catch (e) {
      rethrow;
    } catch (error) {
      debugPrint('Unexpected Google Sign-In error: $error');
      rethrow;
    }
  }

  ///TODO while authenticating firebase
  Future<void> signInWithGoogleFirebase() async {
    try {
      await _ensureGoogleSignInInitialized();
      final GoogleSignInAccount account = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // 4. Prepare User Model
        UserModel newUser = UserModel(
          uid: firebaseUser.uid,
          fullName: firebaseUser.displayName ?? "",
          email: firebaseUser.email ?? "",
          profilePic: firebaseUser.photoURL ?? "",
          gender: "Male", // To be filled by user
          points: 45, // Default points for new users
          isActive: true,
          bio: "",
        );

        await _userRepo.createUserIfNotExist(newUser);
        final user = await _userRepo.watchUser(firebaseUser.uid).first;
        final token = await FirebaseMessaging.instance.getToken();
        _userRepo.updateUserData(user.uid, {"fcmToken": token});
        _saveUserToLocal(user);
        Get.offAllNamed(AppRoutes.HOME);
      }
    } catch (error) {
      debugPrint('Login error: $error');
      Get.snackbar(
        'Login Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _saveUserToLocal(UserModel user) {
    LocalStorage.setUid(user.uid);
    LocalStorage.setEmail(user.email);
    LocalStorage.setFirstName(user.fullName); // You can split name if needed
    LocalStorage.setProfileUrl(user.profilePic);
    LocalStorage.setPoints(user.points);
    LocalStorage.setAccessToken(user.uid);
  }

  // Method to Sign Out
  Future<void> logout() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (error) {
      Get.snackbar('Error', 'Sign out failed: $error');
    }
  }
}
