import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool visibleAppBar;
  const ScreenWrapper({
    super.key,
    required this.child,
    this.title,
    this.visibleAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.peachDarkPurpleSplit),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: visibleAppBar
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(color: Colors.white),
                title: Text(
                  title ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              )
            : null,
        body: SafeArea(child: child),
      ),
    );
  }
}
