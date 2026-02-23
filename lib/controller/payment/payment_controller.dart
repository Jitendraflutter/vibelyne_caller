import 'package:core/core.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:voicly/core/route/routes.dart';
import 'package:voicly/networks/auth_services.dart';
import 'package:voicly/networks/cloud_function_services.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  final authService = Get.find<AuthService>();
  final cloudService = Get.find<CloudFunctionService>();
  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  Future<void> openCheckout(num amountInRupees, int point, String subID) async {
    try {
      Get.snackbar(
        "Please wait",
        "Generating secure order...",
        showProgressIndicator: true,
      );

      // 🟢 1. Call your clean service method
      final responseData = await cloudService.createRazorpayOrder(
        amount: amountInRupees,
        uid: authService.currentUser.value!.uid,
      );

      if (responseData != null && responseData['success'] == true) {
        final String orderId = responseData['orderId'];

        var options = {
          'key': "rzp_test_SIKSHmIcqwONCc",
          'amount': (amountInRupees * 100).toInt(),
          'order_id': orderId, // The secure ID from Firebase!
          'name': 'Voicly App',
          'description': 'Wallet Recharge',
          'prefill': {'email': authService.currentUser.value?.email ?? ""},
          'notes': {
            'uid': authService.currentUser.value!.uid,
            'points': point.toString(), // 🟢 Pass the points here
            'subscriptionId': subID, //
          },
        };

        _razorpay.open(options);
      } else {
        errorSnack("Could not generate order. Please try again.");
      }
    } catch (e) {
      print('Error opening checkout: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // 🟢 DO NOT add points here! Hackers can trigger this function.
    // Just tell the user "Verifying payment..."
    Get.snackbar(
      "Processing",
      "Payment received. Updating your wallet securely...",
    );
    Get.offNamedUntil(AppRoutes.HOME, (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", "Please try again.");
  }

  @override
  void onClose() {
    _razorpay.clear(); // Removes all listeners
    super.onClose();
  }
}
