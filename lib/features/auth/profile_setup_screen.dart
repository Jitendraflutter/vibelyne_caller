import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'widget/base_layout.dart';
import 'widget/custom_text_field.dart';

class ProfileSetupScreen extends StatelessWidget {
  final VoidCallback onComplete;
  const ProfileSetupScreen({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return BaseAuthLayout(
      title: "About You",
      subtitle: "Help us get to know you better",
      child: Column(
        children: [
          CustomTextField(
            hint: "Full Name",
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hint: "Date of Birth",
            icon: Icons.cake_outlined,
            readOnly: true,
          ),
          const SizedBox(height: 40),
          AppButton(text: "Complete Setup", onPressed: onComplete),
        ],
      ),
    );
  }
}
