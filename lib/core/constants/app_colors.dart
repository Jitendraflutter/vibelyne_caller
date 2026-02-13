import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryPeach = Color(0xFFFDB4B8);
  static const Color primaryPeachShade = Color(0xFF9D7476);
  static const Color primaryLavender = Color(0xFFBCB1F1);
  static const Color primaryPurple = Color(0xFF9E8CF4);
  static const Color purpleDark = Color(0xFF3810FF);

  static const Color background = Color(0xFFF8F9FF);
  static const Color surface = Colors.white;

  static const Color primary = Color(0xFFE5A6D3);
  static const Color secondary = primaryLavender;

  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);
  static const Color success = Color(0xFF81C784);

  static const Color onBackground = Colors.white;
  static const Color grey = Color(0xFFD0D0D0);
  // static const Color onBackground = Color(0xFF2D2D2D);
  static const Color onSurface = Color(0xFF2D2D2D);
  static const Color onPrimary = Colors.white;
  static const Color dark = Color(0xFF000000);
  static const Color green = Color(0xFF0BDA51);

  static const LinearGradient logoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryPeach, primaryLavender, primaryPurple],
  );

  static const LinearGradient peachMagentaPremium = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primaryPeach,
      AppColors.primaryPeach,
      Color(0xFFE91EAF),
      Color(0xFFFF00FF),
    ],
    stops: [0.0, 0.28, 0.36, 1.0],
  );
  static const LinearGradient peachDarkPurpleSplit = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      // smooth connection shade
      Color(0xFF7B3FE4), // mid purple blend
      // main dark purple bottom
      Color(0xFF2A0A5E), // deep dark purple
      AppColors.dark,
      AppColors.dark,
    ],
    stops: [
      0.0,
      0.28, // 🔥 top 28% peach
      0.36, // blend divider zone
      1.0,
    ],
  );
}
