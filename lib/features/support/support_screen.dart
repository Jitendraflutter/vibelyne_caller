import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:voicly/widget/screen_wrapper.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Help & Support',
      visibleAppBar: true,
      child: SingleChildScrollView(
        // Changed to ScrollView to handle more content
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Message ---
            Text(
              'How can we help?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a way to connect with our team.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 32),

            // --- Primary Action: Email Card (The Highlight) ---
            _buildPremiumCard(
              icon: Icons.alternate_email_rounded,
              title: 'Email Support',
              subtitle: AppStrings.email,
              caption: 'Response time: < 24 hours',
              onTap: () {},
            ),
            const SizedBox(height: 24),

            // --- Section Title ---
            _buildSectionTitle('Self-Service & Community'),
            const SizedBox(height: 16),

            // --- Secondary Actions: Grid Layout ---
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildCompactTile(
                  icon: Icons.help_outline_rounded,
                  label: 'FAQs',
                  color: const Color(0xFF6366F1),
                ),
                _buildCompactTile(
                  icon: Icons.description_outlined,
                  label: 'Guides',
                  color: const Color(0xFF10B981),
                ),
                _buildCompactTile(
                  icon: Icons.discord_rounded, // or any social icon
                  label: 'Community',
                  color: const Color(0xFF5865F2),
                ),
                _buildCompactTile(
                  icon: Icons.update_rounded,
                  label: 'Changelog',
                  color: const Color(0xFFF59E0B),
                ),
              ],
            ),

            const SizedBox(height: 32),

            AppInfo(isVisible: true),
          ],
        ),
      ),
    );
  }

  // --- Premium Main Card Builder ---
  Widget _buildPremiumCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String caption,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1E1C28), Color(0xFF13111A)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF321B3E),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: const Color(0xFFD4A5FF), size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withOpacity(0.2),
                  size: 16,
                ),
              ],
            ),
            const Divider(height: 32, color: Colors.white10),
            Row(
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  color: Color(0xFFF59E0B),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  caption,
                  style: const TextStyle(
                    color: Color(0xFFF59E0B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Compact Tile Builder ---
  Widget _buildCompactTile({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: Colors.white.withOpacity(0.4),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}
