import 'package:flutter/material.dart';
import 'package:voicly/widget/app_button.dart';
import 'package:voicly/features/auth/widget/base_layout.dart';
import '../../core/constants/app_colors.dart';

class OTPScreen extends StatelessWidget {
  final VoidCallback onNext;
  const OTPScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return BaseAuthLayout(
      title: "Verify Phone",
      subtitle: "We've sent a 4-digit code to your number",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _otpBox()),
          ),
          const SizedBox(height: 40),
          AppButton(text: "Verify", onPressed: onNext),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Resend Code",
              style: TextStyle(color: AppColors.primaryPurple),
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpBox() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(border: InputBorder.none, counterText: ""),
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
