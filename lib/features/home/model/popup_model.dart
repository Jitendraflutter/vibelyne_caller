import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:voicly/core/constant/app_assets.dart';


enum PopupType { discount, notice, feature, caller }

class PopupModel {
  final PopupType type;
  final String title;
  final String description;
  final String btnText;
  final IconData icon;
  final String? avatarUrl;

  // UI elements
  final String? imageUrl;
  final String? highlightText;
  final String? subHighlightText;

  // Dynamic Data
  final String? category;
  final String? discountText;

  // Value Labels
  final String? pointsLabel;
  final String? originalPriceLabel;

  // Values
  final double? originalPrice;
  final double? price;
  final int? points;
  final String currency;

  PopupModel({
    required this.type,
    required this.title,
    required this.description,
    required this.btnText,
    required this.icon,
    this.avatarUrl,
    this.imageUrl,
    this.highlightText,
    this.subHighlightText,
    this.category,
    this.discountText,
    this.pointsLabel,
    this.originalPriceLabel,
    this.originalPrice,
    this.price,
    this.points,
    this.currency = '₹',
  });

  // --- Dummy Data Generator ---
  static List<PopupModel> get dummyData => [
    // 1. New Detailed Discount (Deep Talk)
    PopupModel(
      type: PopupType.discount,
      title: 'Limited Offer!',
      description:
          'Someone is waiting to talk to you. Get more coins at half the price. Valid for 24h.',
      category: 'Recommended Pack',
      discountText: '30% OFF',
      points: 96,
      pointsLabel: 'Points', // Dynamic label
      price: 49,
      originalPrice: 70,
      originalPriceLabel: 'Original', // Dynamic label
      currency: '₹',
      btnText: 'Claim Now',
      icon: Icons.auto_awesome_rounded,
    ),
    PopupModel(
      type: PopupType.discount, // Reusing discount UI for the pricing table
      title: 'Low Balance!',
      description:
          'Someone special is waiting for your call, but your points are running low. Recharge now to connect!',
      category: 'Urgent Recharge',
      discountText: 'BONUS +20%',
      points: 200,
      pointsLabel: 'Top-up Points',
      price: 99,
      originalPrice: 120,
      originalPriceLabel: 'Standard Price',
      currency: '₹',
      btnText: 'Recharge & Call',
      icon: Icons.account_balance_wallet_rounded,
    ),
    // 2. Caller Online
    PopupModel(
      type: PopupType.caller,
      title: 'Sarah is Online',
      description: 'Your favorite caller is back! Start a conversation.',
      btnText: 'Call Now',
      icon: Icons.phone_in_talk_rounded,
      avatarUrl: AppAssets.userUrl,
      imageUrl: 'https://i.pravatar.cc/150?u=sarah',
    ),

    // 3. New Feature
    PopupModel(
      type: PopupType.feature,
      title: 'Voice Filters',
      description: 'Transform your voice into 10+ characters.',
      btnText: 'Try Features',
      icon: Icons.rocket_launch_rounded,
      highlightText: 'NEW',
      subHighlightText: 'v2.0',
    ),

    PopupModel(
      type: PopupType.notice,
      title: 'System Update',
      description: 'Maintenance tonight at 12:00 AM.',
      btnText: 'Got it',
      icon: Icons.info_outline_rounded,
    ),
  ];
}

/*
import 'package:flutter/material.dart';

enum PopupType { discount, notice, feature, caller }

class PopupModel {
  final PopupType type;
  final String title;
  final String description;
  final String btnText;
  final IconData icon;
  final String? highlightText; // e.g., "50%" or "v2.0"
  final String? subHighlightText; // e.g., "OFF"
  final String? imageUrl; // For caller avatars

  PopupModel({
    required this.type,
    required this.title,
    required this.description,
    required this.btnText,
    required this.icon,
    this.highlightText,
    this.subHighlightText,
    this.imageUrl,
  });

  // Dummy Data Generator
  static List<PopupModel> get dummyData => [
    PopupModel(
      type: PopupType.discount,
      title: 'Limited Offer!',
      description: 'Get premium access at half the price. Valid for 24h.',
      btnText: 'Claim Now',
      icon: Icons.card_giftcard_rounded,
      highlightText: '50%',
      subHighlightText: 'OFF',
    ),
    PopupModel(
      type: PopupType.caller,
      title: 'Sarah is Online',
      description: 'Your favorite caller is back! Start a conversation now.',
      btnText: 'Call Now',
      icon: Icons.phone_in_talk_rounded,
      imageUrl: 'https://i.pravatar.cc/150?u=sarah',
    ),
    PopupModel(
      type: PopupType.feature,
      title: 'Voice Filters',
      description:
          'New AI filters added! Transform your voice into 10+ characters.',
      btnText: 'Try Features',
      icon: Icons.auto_awesome_rounded,
      highlightText: 'NEW',
    ),
    PopupModel(
      type: PopupType.notice,
      title: 'System Update',
      description: 'We are scheduled for maintenance tonight at 12:00 AM.',
      btnText: 'Got it',
      icon: Icons.info_outline_rounded,
    ),
  ];
}
*/
