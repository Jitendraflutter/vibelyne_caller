import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/popup_controller.dart';
import '../model/popup_model.dart';
import 'package:core/core.dart';


class DynamicPopup extends StatelessWidget {
  final PopupModel data;

  const DynamicPopup({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        backgroundColor: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // Content Container
            Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              decoration: BoxDecoration(
                color: const Color(0xFF13111A),
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Dynamic Content Center-piece
                  _buildCenterContent(),

                  const SizedBox(height: 32),
                  AppButton(text: data.btnText, onPressed: () {}),
                ],
              ),
            ),
            // Floating Header Icon
            _buildFloatingHeader(data.avatarUrl),
            _buildCloseBtn(),
          ],
        ),
      ),
    );
  }

  // --- Sub-Widgets to manage complexity ---

  /*Widget _buildCenterContent() {
    if (data.type == PopupType.caller) {
      return CircleAvatar(
        radius: 40,
        backgroundColor: AppColors.primaryPurple,
        child: CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(data.imageUrl!),
        ),
      );
    }
    if (data.highlightText != null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryButtonGradient.createShader(bounds),
              child: Text(
                data.highlightText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            if (data.subHighlightText != null) ...[
              const SizedBox(width: 10),
              Text(
                data.subHighlightText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }*/

  Widget _buildFloatingHeader(String? imageUrl) {
    return Positioned(
      top: -30,
      child: Container(
        padding: const EdgeInsets.all(5), // border spacing
        decoration: BoxDecoration(
          gradient: AppColors.vibrantSunsetColor,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF13111A), width: 5),
        ),
        child: ClipOval(
          child: SizedBox(
            height: 70,
            width: 70,
            child: imageUrl != null
                ? VoiclyAvatar(imageUrl: imageUrl)
                : Icon(data.icon, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseBtn() {
    return Positioned(
      top: 0,
      right: 10,
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.close),
        color: Colors.white,
      ),
    );
  }

  Widget _buildCenterContent() {
    if (data.type == PopupType.discount) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            // --- Top Row: Points & Discount ---
            if (data.category != null)
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryButtonGradient.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.category!,
                  style: TextStyle(
                    color: AppColors.onBackground,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.pointsLabel != null)
                      Text(
                        data.pointsLabel!.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.primaryLavender,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    Text(
                      '${data.points}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (data.discountText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data.discountText!,
                      style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: Colors.white10, thickness: 1),
            ),

            // --- Bottom Row: Prices ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.originalPriceLabel != null)
                      Text(
                        data.originalPriceLabel!.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 10,
                        ),
                      ),
                    Text(
                      '${data.currency}${data.originalPrice}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                // Main Price with your Primary Gradient
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryButtonGradient.createShader(bounds),
                  child: Text(
                    '${data.currency}${data.price}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
