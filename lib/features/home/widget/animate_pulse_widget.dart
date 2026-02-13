import 'dart:async';
import 'package:flutter/material.dart';
import 'package:voicly/core/constants/app_colors.dart';
import 'package:voicly/features/home/model/banner_model.dart';
import '../../../core/constants/app_assets.dart';

class AnimatedPulseWidget extends StatefulWidget {
  final BannerModel banner;
  final VoidCallback onTap;
  final bool visible;

  const AnimatedPulseWidget({
    super.key,
    required this.onTap,
    this.visible = false,
    required this.banner,
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
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: (widget.banner.imageUrl.isEmpty)
                ? AppColors.peachDarkPurpleSplit
                : null,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPeach.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(widget.banner.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              /// 👇 Your Existing Content
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.banner.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.banner.subtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.banner.targetScreen == '/matching_screen')
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(AppAssets.userUrl),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
