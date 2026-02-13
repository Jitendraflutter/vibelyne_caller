/*
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../core/constants/app_assets.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true, // allows bg behind appbar
      backgroundColor: Colors.black,
      appBar: visibleAppBar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: BackButton(color: Colors.white.withOpacity(0.9)),
                centerTitle: true,
                title: Text(
                  title ?? '',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          /// 🔥 Background image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: AppAssets.backgroundImg[4],
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.black),
            ),
          ),

          /// 🔥 Blur + dark overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.35),
                      Colors.transparent,
                      Colors.black.withOpacity(0.45),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🔥 Main content
          SafeArea(child: child),
        ],
      ),
    );
  }
}
*/

/*
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1a1a2e), // deep blue-black
            Color(0xFF16213e), // darker blue
            Color(0xFF0f1419), // almost black
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.8),
            radius: 1.5,
            colors: [
              Color(
                0xFF8B7BA8,
              ).withOpacity(0.15), // subtle purple glow from logo
              Colors.transparent,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: visibleAppBar
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: BackButton(
                    color: Color(0xFFE8B4C8), // soft pink from logo
                  ),
                  title: Text(
                    title ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  centerTitle: true,
                )
              : null,
          body: SafeArea(child: child),
        ),
      ),
    );
  }
}*/

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
      // decoration: const BoxDecoration(gradient: AppColors.peachDarkPurpleSplit),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.4, -0.6), // top glow
          radius: 1.5,
          colors: [
            // Color(0xFF5B4D8A), // soft purple glow (top center)
            AppColors.primaryPeachShade,
            Color(0xFF2B2F3A), // bluish dark mid
            Color(0xFF0D0F14), // deep black edges
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
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
