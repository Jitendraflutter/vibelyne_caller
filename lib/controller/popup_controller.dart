import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../features/home/model/popup_model.dart';
import '../features/home/widget/discount_popup.dart';

class PopupController extends GetxController {
  Timer? _autoTriggerTimer;
  final RxBool isPopupOpen = false.obs;
  final RxBool _isPopupActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 1. Show a welcome/discount popup when the app opens
    // showStartupPopup();
  }

  void showWelcomePopupWithDelay({
    required int seconds,
    required int popupIndex,
  }) {
    Future.delayed(Duration(seconds: seconds), () {
      // Check if a popup is already showing to avoid overlapping
      if (!_isPopupActive.value) {
        _displayPopup(
          PopupModel.dummyData[popupIndex],
        ); // Show the Discount popup
      }
    });
  }

  // void _displayPopup(PopupModel data) {
  //   _isPopupActive.value = true;
  //
  //   Get.dialog(
  //     DynamicPopup(data: data),
  //     barrierDismissible: true,
  //     transitionCurve: Curves.easeOutBack,
  //   ).then((_) {
  //     // Reset flag when the user closes the popup
  //     _isPopupActive.value = false;
  //   });
  // }

  void showStartupPopup() {
    Future.delayed(const Duration(seconds: 2), () {
      triggerPopup(PopupModel.dummyData[0]); // Show Discount
    });
  }

  void triggerPopup(PopupModel data) {
    if (isPopupOpen.value) return; // Don't stack popups

    isPopupOpen.value = true;

    Get.dialog(
      DynamicPopup(data: data),
      barrierDismissible: true,
      transitionCurve: Curves.easeInOutBack,
    ).then((_) {
      isPopupOpen.value = false;
    });
  }

  void _displayPopup(PopupModel data) {
    if (Get.currentRoute == '/home') {
      _isPopupActive.value = true;
      Get.dialog(
        DynamicPopup(data: data),
      ).then((_) => _isPopupActive.value = false);
    }
  }

  void checkBalanceAndCall(int userPoints) {
    if (userPoints < 10) {
      showWelcomePopupWithDelay(seconds: 3, popupIndex: 1);
    } else {
      showWelcomePopupWithDelay(seconds: 3, popupIndex: 0);
    }
  }

  @override
  void onClose() {
    _autoTriggerTimer?.cancel(); // Auto dispose timer
    super.onClose();
  }
}
