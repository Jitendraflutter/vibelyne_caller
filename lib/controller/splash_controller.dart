import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicly/core/utils/local_storage.dart';

import '../core/route/routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutBack,
    );

    animationController.forward();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goNext();
      }
    });
  }

  void _goNext() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (LocalStorage.getUid().isNotEmpty) {
      Get.offAllNamed(AppRoutes.HOME);
      return;
    }
    Get.offAllNamed(
      AppRoutes.LOGIN, // or AppRoutes.BOTTOM_BAR
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
