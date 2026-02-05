import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  final emailController = TextEditingController(
    text: kReleaseMode ? "" : "test@gmail.com",
  );

  final mobileController = TextEditingController();
  final passwordController = TextEditingController(
    text: kReleaseMode ? "" : "test12345678",
  );

  final formKey = GlobalKey<FormState>();

  var isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  @override
  void onReady() {
    _initializeGoogleSignIn();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // void validateGoogleToken(String token) async {
  //   try {
  //     final fcmToken = await FirebaseMessaging.instance.getToken();
  //     final res = await _auth.validateGoogleToken({
  //       "firebase_token": token,
  //       "fcm_token": fcmToken,
  //     });
  //
  //     res.fold((l) => errorSnack(l.message), (data) {
  //       if (data.code == 200 || data.code == 201) {
  //
  //       } else {
  //         warningSnack(data.error?.details?.toString() ?? "");
  //       }
  //     });
  //   } finally {
  //     // TODO
  //   }
  // }

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

  // 2. Reactive variable to hold the user
  // Rxn is a reactive nullable type (Rx<GoogleSignInAccount?>)

  // Method to Sign In

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
  Future<UserCredential> signInWithGoogleFirebase() async {
    await _ensureGoogleSignInInitialized();
    //final GoogleSignInAccount? googleUser =_googleSignIn.authenticate();
    final GoogleSignInAccount account = await _googleSignIn.authenticate(
      // Specify required scopes
    );
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = account.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
