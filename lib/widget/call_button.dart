import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const CallButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,

          border: Border.all(color: color.withOpacity(0.2), width: 0.5),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}
