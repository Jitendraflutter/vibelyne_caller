import 'package:flutter/material.dart';
import 'package:voicly/core/constants/app_colors.dart';
import 'package:voicly/core/constants/app_strings.dart';

class AppInfo extends StatelessWidget {
  final bool showVersion;
  final bool isVisible;

  const AppInfo({super.key, this.showVersion = true, this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${AppStrings.appName} ${AppStrings.appVersion}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
