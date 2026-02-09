
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BaseAuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const BaseAuthLayout({super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Decorative top gradient splash
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.logoGradient.withOpacity(0.2),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onBackground,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.onBackground.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 60),
                child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
