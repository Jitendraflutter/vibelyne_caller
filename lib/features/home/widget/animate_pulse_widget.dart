import 'dart:async';
import 'package:flutter/material.dart';
import 'package:voicly/core/constants/app_colors.dart';

import '../../../core/constants/app_assets.dart';

class AnimatedPulseWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool visible;

  const AnimatedPulseWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.visible = false,
  });

  @override
  State<AnimatedPulseWidget> createState() => _AnimatedPulseWidgetState();
}

class _AnimatedPulseWidgetState extends State<AnimatedPulseWidget> {
  double _scale = 1.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Handles the automatic "inflate" animation loop
    _timer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (mounted) {
        setState(() {
          _scale = (_scale == 1.0) ? 1.06 : 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(22, 30, 22, 20),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            // gradient: const LinearGradient(
            //   colors: [Color(0xFFFF4B2B), Color(0xFFFF416C)],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),
            gradient: AppColors.peachDarkPurpleSplit,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPeach.withOpacity(0.4),
                // color: const Color(0xFFFF416C).withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(AppAssets.userUrl),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
