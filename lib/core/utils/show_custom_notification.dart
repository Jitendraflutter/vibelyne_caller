import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnack(String message) {
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  Get.snackbar(
    "Error",
    message,
    icon: Icon(Icons.cancel, color: Colors.black),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red.shade50,
    leftBarIndicatorColor: Colors.red,
    borderRadius: 3,
  );
}

void successSnack(String message) {
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  Get.snackbar(
    "Success",
    message,
    icon: Icon(Icons.check, color: Colors.black),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.green.shade50,
    leftBarIndicatorColor: Colors.green,
    borderRadius: 3,
  );
}

void warningSnack(String message) {
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  Get.snackbar(
    "Warning",
    message,
    backgroundColor: Colors.amber.shade50,
    icon: const Icon(Icons.warning_amber, color: Colors.black),
    snackPosition: SnackPosition.TOP,
    leftBarIndicatorColor: Colors.amber,
    borderRadius: 5,
  );
}
