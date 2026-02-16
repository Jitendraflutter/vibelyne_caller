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
import 'package:lottie/lottie.dart';
import 'package:voicly/core/constants/app_assets.dart';
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
    final statusBar = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0B0220),
                Color(0xFF14052E),
                // Color(0xFF1B063A),
                Color(
                  0xFF000000,
                ), // black at bottom to ensure deep fade and hide any content behind

                Color(0xFF0B0C12),
                Color(0xFF000000),
              ],
              stops: [0.0, 0.3, 0.5, 0.8, 1.0],
            ),
          ),
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.85, -0.95),
              radius: 0.9,
              colors: [
                Color(0xFF1B063A),
                Color(0xFF14052E),
                Colors.transparent,
              ],
              stops: [0.0, 0.35, 1.0],
            ),
          ),
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.7, -0.9),
              radius: 0.8,
              colors: [Color(0xFF1B063A), Colors.transparent],
              stops: [0.0, 1.0],
            ),
          ),
        ),

        // Positioned(
        //   top: -statusBar,
        //   left: 0,
        //   right: 0,
        //   height: MediaQuery.of(context).size.height * 0.30 + statusBar,
        //   child: Lottie.asset(AppAssets.animation2, fit: BoxFit.cover, addRepaintBoundary: true, ),
        // ),
        Scaffold(
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
      ],
    );
  }
}
