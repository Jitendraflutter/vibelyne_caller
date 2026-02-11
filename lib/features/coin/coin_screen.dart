import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voicly/widget/screen_wrapper.dart';

import '../../core/constants/app_colors.dart';
// import 'your_path/app_colors.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  int? selectedPackageIndex; // Track which coin card is selected
  String selectedPaymentMethod = "UPI";

  final List<Map<String, dynamic>> coinPackages = [
    {"coins": 100, "bonus": 0, "price": 100, "discount": "0%"},
    {"coins": 500, "bonus": 50, "price": 450, "discount": "10%"},
    {"coins": 1000, "bonus": 150, "price": 850, "discount": "15%"},
    {"coins": 5000, "bonus": 1000, "price": 4000, "discount": "20%"},
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      visibleAppBar: true,
      title: "Buy Coins",
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildCurrentBalanceHeader(),
                const SizedBox(height: 25),
                const Text(
                  "Select Package",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),

                // Grid of Coin Cards
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: coinPackages.length,
                  itemBuilder: (context, index) => _buildCoinCard(index),
                ),

                const SizedBox(height: 30),
                const Text(
                  "Payment Method",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),
                _buildPaymentSelection(),

                const SizedBox(height: 140), // Space for the bottom buy bar
              ],
            ),
          ),

          // Floating Bottom Purchase Bar
          _buildBottomPurchaseBar(),
        ],
      ),
    );
  }

  // --- HEADER: CURRENT BALANCE ---
  Widget _buildCurrentBalanceHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Balance",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    "1,250 Coins",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.monetization_on_rounded,
                color: Colors.amber.shade400,
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- COIN SELECTION CARD ---
  Widget _buildCoinCard(int index) {
    bool isSelected = selectedPackageIndex == index;
    var pkg = coinPackages[index];

    return GestureDetector(
      onTap: () => setState(() => selectedPackageIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.4)
              : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pkg['discount'] != "0%")
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    pkg['discount'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const Icon(
              Icons.monetization_on_rounded,
              color: Colors.amber,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              "${pkg['coins']}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (pkg['bonus'] > 0)
              Text(
                "+${pkg['bonus']} Bonus",
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const Spacer(),
            Text(
              "₹${pkg['price']}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- PAYMENT SELECTION ---
  Widget _buildPaymentSelection() {
    return _buildGlassContainer(
      child: Column(
        children: [
          _buildPaymentTile(
            "UPI (PhonePe/Google Pay)",
            CupertinoIcons.device_phone_portrait,
            "UPI",
          ),
          const Divider(color: Colors.white24, height: 1),
          _buildPaymentTile(
            "Credit/Debit Card",
            CupertinoIcons.creditcard,
            "CARD",
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTile(String title, IconData icon, String value) {
    bool isSelected = selectedPaymentMethod == value;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => setState(() => selectedPaymentMethod = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Icon(
              isSelected
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.circle,
              color: isSelected ? AppColors.success : Colors.white30,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  // --- FLOATING BOTTOM BUY BAR ---
  Widget _buildBottomPurchaseBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 120,
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 40),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              border: const Border(top: BorderSide(color: Colors.white24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total Amount",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      selectedPackageIndex != null
                          ? "₹${coinPackages[selectedPackageIndex!]['price']}"
                          : "₹0",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildPurchaseButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPurchaseButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: selectedPackageIndex == null ? null : () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          gradient: selectedPackageIndex == null
              ? null
              :AppColors.logoGradient,
          color: selectedPackageIndex == null ? Colors.white10 : null,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            if (selectedPackageIndex != null)
              BoxShadow(
                color: const Color(0xFF4A00E0).withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: const Text(
          "Purchase Now",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
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
