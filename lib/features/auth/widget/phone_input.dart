import 'package:flutter/material.dart';
import '../../../widget/app_button.dart';
import 'base_layout.dart';
import 'custom_text_field.dart';

class PhoneInputScreen extends StatelessWidget {
  final VoidCallback onNext;
  const PhoneInputScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return BaseAuthLayout(
      title: "Welcome!",
      subtitle: "Enter your mobile number to get started",
      child: Column(
        children: [
          CustomTextField(
            hint: "Mobile Number",
            icon: Icons.phone_android_rounded,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 30),
          AppButton(text: "Send OTP", onPressed: onNext),
        ],
      ),
    );
  }
}
