import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:voicly/widget/screen_wrapper.dart';

class BecomeCallerScreen extends StatelessWidget {
  const BecomeCallerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Join the Team',
      visibleAppBar: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // --- Premium Gradient Header ---
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.vibrantSunsetColor.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              child: const Text(
                'Become a Caller on Voicly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: AppColors.onBackground, // Required for ShaderMask
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Earn by talking with new people. Join Voicly as a caller and start connecting with users through voice conversations anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            // --- Benefits Glass Card ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                children: [
                  _buildCheckItem('Earn while talking'),
                  _buildCheckItem('Flexible timing'),
                  _buildCheckItem('Work from home'),
                  _buildCheckItem('Instant weekly payouts', isLast: true),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // --- Extra Content: How it Works ---
            _buildSectionTitle('HOW IT WORKS'),
            const SizedBox(height: 24),
            _buildStepRow(
              '01',
              'Complete Profile',
              'Fill in your details and voice samples.',
            ),
            _buildStepRow(
              '02',
              'Get Verified',
              'Our team will review your application.',
            ),
            _buildStepRow(
              '03',
              'Start Earning',
              'Take calls and earn per minute.',
            ),

            const SizedBox(height: 40),

            AppButton(
              text: 'Apply Now',
              onPressed: () {
                warningSnack('This feature is coming soon! Stay tuned.');
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---

  Widget _buildCheckItem(String text, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFF2D1B4E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.primaryLavender,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.onBackground,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepRow(String number, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryPurple.withOpacity(0.3),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.onBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primaryPeach.withOpacity(0.7),
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
