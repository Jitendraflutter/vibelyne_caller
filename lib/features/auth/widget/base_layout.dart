import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:voicly/widget/screen_wrapper.dart';


class BaseAuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const BaseAuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      // Added Scaffold to provide a proper white background and keyboard handling
      child: Stack(
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
            child: LayoutBuilder(
              // 1. Added LayoutBuilder to get screen constraints
              builder: (context, constraints) {
                return SingleChildScrollView(
                  // 2. Added ScrollView to prevent overflow on small screens
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints
                          .maxHeight, // 3. Force column to be at least screen height
                    ),
                    child: IntrinsicHeight(
                      // 4. Allows Spacer() to work correctly
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
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(height: 60),

                            // This is where your PhoneInputScreen content goes
                            // If you use Spacer() in the child, it will now work!
                            Expanded(child: child),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*

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
*/
