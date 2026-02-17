import 'package:flutter/material.dart';
import 'package:voicly/features/call/mini_call_overlay.dart';

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
                Color(0xFF000000),

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
        const Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: MiniCallOverlay(),
        ),
      ],
    );
  }
}
