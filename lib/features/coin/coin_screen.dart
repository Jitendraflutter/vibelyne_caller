import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core/core.dart';
import 'package:voicly/features/coin/widget/point_card.dart';
import '../../controller/coin_controller.dart';
import '../../networks/auth_services.dart';
import 'package:voicly/core/constant/app_assets.dart';


class CoinScreen extends StatelessWidget {
  const CoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoinController());
    final authService = Get.find<AuthService>();

    return ScreenWrapper(
      visibleAppBar: true,
      title: "Voicly Points Store",
      child: Stack(
        children: [
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryLavender,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildCurrentBalanceHeader(authService),
                        ..._buildCategoryGroup(
                          controller,
                          "Welcome Offers",
                          "welcome",
                        ),
                        ..._buildCategoryGroup(
                          controller,
                          "Best Value",
                          "recommended",
                        ),
                        ..._buildCategoryGroup(
                          controller,
                          "Starter",
                          "starter",
                        ),
                        ..._buildCategoryGroup(controller, "Elite", "elite"),
                        const SizedBox(height: 140),
                      ],
                    ),
                  ),
          ),
          _buildBottomPurchaseBar(controller, context),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryGroup(
    CoinController controller,
    String title,
    String cat,
  ) {
    final filtered = controller.pointPacks
        .where((p) => p.category == cat)
        .toList();
    if (filtered.isEmpty) return [];

    return [
      Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.82,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index) => Obx(
          () => EnhancedCoinCard(
            pack: filtered[index],
            isSelected: controller.selectedPack?.id == filtered[index].id,
            onTap: () {
              // Find global index to update controller
              int globalIdx = controller.pointPacks.indexOf(filtered[index]);
              controller.selectedIndex.value = globalIdx;
            },
          ),
        ),
      ),
    ];
  }

  // --- HEADER: CURRENT BALANCE ---
  Widget _buildCurrentBalanceHeader(AuthService auth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Balance",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  Obx(() {
                    final user = auth.currentUser.value;
                    return Text(
                      "${(auth.currentUser.value?.points ?? 0).toString()} VP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackground,
                      ),
                    );
                  }),
                ],
              ),
              Image.asset(
                AppAssets.vp,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- FLOATING BOTTOM PURCHASE BAR ---
  Widget _buildBottomPurchaseBar(
    CoinController controller,
    BuildContext context,
  ) {
    return Obx(() {
      final selected = controller.selectedPack;
      final bool hasSelection = selected != null;

      // Calculate savings if original price exists
      int savings = 0;
      if (hasSelection && selected.originalPrice != null) {
        savings = selected.originalPrice! - selected.price;
      }

      return Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // Increase height slightly when selected to show details
              height: hasSelection ? 130 : 100,
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                border: const Border(top: BorderSide(color: Colors.white12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasSelection)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selected.points} Points selected",
                            style: const TextStyle(
                              color: AppColors.primaryLavender,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (savings > 0)
                            Text(
                              "You save ₹$savings!",
                              style: const TextStyle(
                                color: AppColors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),

                  // --- BOTTOM ACTION ROW ---
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Total Payable",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Expanded(
                              child: Text(
                                hasSelection
                                    ? "₹${selected.price}"
                                    : "Select a pack",
                                style: TextStyle(
                                  color: hasSelection
                                      ? Colors.white
                                      : Colors.white38,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(() {
                          bool hasSelection =
                              controller.selectedIndex.value != -1;
                          return !hasSelection
                              ? SizedBox.shrink()
                              : AppButton(
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  text: 'Purchase Now',
                                  onPressed: () {},
                                );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildGlassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}
