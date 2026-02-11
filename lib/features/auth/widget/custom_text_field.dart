import 'package:flutter/material.dart';
import 'package:voicly/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(icon, color: AppColors.primaryPurple),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
