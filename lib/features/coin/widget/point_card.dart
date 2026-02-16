import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../model/point_pack_model.dart';

class EnhancedCoinCard extends StatelessWidget {
  final PointPackModel pack; // Passing the full model
  final bool isSelected;
  final VoidCallback onTap;

  const EnhancedCoinCard({
    super.key,
    required this.pack,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.white.withOpacity(0.08),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryLite
                : (pack.isPopular ? AppColors.green : Colors.white12),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryLite.withOpacity(0.2),
                    blurRadius: 15,
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              if (pack.discountPercent != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      pack.discountPercent!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.vp,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${pack.points}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      pack.title,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),

                    // SLIDING DESCRIPTION
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 18,
                      child: Marquee(
                        text: pack.description,
                        style: const TextStyle(
                          color: AppColors.primaryLavender,
                          fontSize: 11,
                        ),
                        velocity: 30.0,
                        blankSpace: 20.0,
                        pauseAfterRound: const Duration(seconds: 2),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (pack.originalPrice != null)
                          Text(
                            "₹${pack.originalPrice}",
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const SizedBox(width: 6),
                        Text(
                          "₹${pack.price}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
