import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

Future<void> injectBanners() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final WriteBatch batch = firestore.batch();
  final CollectionReference collection = firestore.collection('banners');

  try {
    for (var bannerData in attractiveBanners) {
      // We still need the id to name the document
      String docId = bannerData['id'];

      // We pass the data exactly as it is in the JSON
      batch.set(collection.doc(docId), bannerData);
    }

    await batch.commit();
    Get.snackbar("Success", "Banners injected with all fields! 🚀");
  } catch (e) {
    Get.snackbar("Error", "Injection failed: $e");
  }
}

final List<Map<String, dynamic>> attractiveBanners = [
  {
    "id": "match_banner",
    "title": "Your Soulmate is Calling! 💖",
    "subtitle": "Skip the small talk. Connect with someone special instantly.",
    "image_url": "YOUR_STORAGE_URL", // Replace with your actual URL
    "action_type": "navigation",
    "target_screen": "/matching_screen",
    "display_order": 1,
    "is_active": true,
  },
  {
    "id": "discount_banner",
    "title": "VIP Loot: 60% EXTRA! 🚀",
    "subtitle":
        "Level up your game. Grab our most popular pack before it's gone.",
    "image_url": "YOUR_STORAGE_URL",
    "action_type": "navigation",
    "target_screen": "/coin_screen",
    "display_order": 2,
    "is_active": true,
  },
  {
    "id": "festival_banner",
    "title": "Light Up Your Vibe! 🪔",
    "subtitle": "Exclusive Festive Points are live. Share the joy of talking.",
    "image_url": "YOUR_STORAGE_URL",
    "action_type": "navigation",
    "target_screen": "/coin_screen",
    "display_order": 3,
    "is_active": true,
  },
];

Future<void> injectPointPacks() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final WriteBatch batch = firestore.batch();
  final CollectionReference collection = firestore.collection('point_packs');

  // The remaining 9 packs based on your requirements
  final List<Map<String, dynamic>> remainingPacks = [
    {
      "id": "silence_8",
      "badge_text": "STARTER",
      "category": "starter",
      "description": "Bypass the silence",
      "discount_percent": "33% OFF",
      "display_order": 2,
      "is_one_time": false,
      "original_price": 12,
      "points": 12,
      "price": 8,
      "title": "Silence Breaker",
    },
    {
      "id": "ice_23",
      "badge_text": "",
      "category": "starter",
      "description": "Get comfortable",
      "discount_percent": "23% OFF",
      "display_order": 3,
      "is_one_time": false,
      "original_price": 30,
      "points": 45,
      "price": 23,
      "title": "Ice Breaker",
    },
    {
      "id": "deep_49",
      "badge_text": "",
      "category": "recommended",
      "description": "Heart-to-heart ready",
      "discount_percent": "30% OFF",
      "display_order": 4,
      "is_one_time": false,
      "original_price": 70,
      "points": 96,
      "price": 49,
      "title": "Deep Talk",
    },
    {
      "id": "plus_75",
      "badge_text": "",
      "category": "recommended",
      "description": "Keep the flow going",
      "discount_percent": "25% OFF",
      "display_order": 5,
      "is_one_time": false,
      "original_price": 100,
      "points": 150,
      "price": 75,
      "title": "Vibe Plus",
    },
    {
      "id": "master_99",
      "badge_text": "BEST SELLER",
      "category": "recommended",
      "description": "Most Popular Choice",
      "discount_percent": "50% OFF",
      "display_order": 6,
      "is_one_time": false,
      "is_popular": true,
      "original_price": 199,
      "points": 198,
      "price": 99,
      "title": "Vibe Master ⭐",
    },
    {
      "id": "uninterrupted_149",
      "badge_text": "",
      "category": "elite",
      "description": "Don't let the magic end",
      "discount_percent": "25% OFF",
      "display_order": 7,
      "is_one_time": false,
      "original_price": 200,
      "points": 306,
      "price": 149,
      "title": "Uninterrupted",
    },
    {
      "id": "soul_299",
      "badge_text": "LATE NIGHT",
      "category": "elite",
      "description": "For the endless nights",
      "discount_percent": "25% OFF",
      "display_order": 8,
      "is_one_time": false,
      "original_price": 400,
      "points": 621,
      "price": 299,
      "title": "Midnight Soul",
    },
    {
      "id": "limitless_499",
      "badge_text": "ULTIMATE",
      "category": "elite",
      "description": "Forget the clock",
      "discount_percent": "40% OFF",
      "display_order": 9,
      "is_one_time": false,
      "original_price": 830,
      "points": 1053,
      "price": 499,
      "title": "Limitless Vibe",
    },
    {
      "id": "legendary_999",
      "badge_text": "SAVINGS PACK",
      "category": "elite",
      "description": "Best Value: 200+ Bonus",
      "discount_percent": "60% OFF",
      "display_order": 10,
      "is_one_time": false,
      "original_price": 2499,
      "points": 2205,
      "price": 999,
      "title": "Legendary Status",
    },
  ];

  for (var pack in remainingPacks) {
    // Extract ID and remove it from the map to keep fields clean
    String docId = pack['id'];
    Map<String, dynamic> data = Map.from(pack)..remove('id');

    batch.set(collection.doc(docId), data);
  }

  try {
    await batch.commit();
    debugPrint("✅ All 9 packs injected successfully!");
  } catch (e) {
    debugPrint("❌ Error injecting packs: $e");
  }
}

Future<void> syncAvatarsToFirestore() async {
  try {
    debugPrint("Starting Storage fetch...");
    // 1. Reference the folder from your screenshot
    final storageRef = FirebaseStorage.instance.ref("avatars/default");

    // 2. List all files
    final ListResult result = await storageRef.listAll();
    debugPrint("Found ${result.items.length} files.");

    List<String> urlList = [];

    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      urlList.add(url);
    }

    await FirebaseFirestore.instance.collection('avatar').doc('default').set({
      'urls': urlList,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    debugPrint("Success! Firestore updated with ${urlList.length} URLs.");
  } catch (e) {
    debugPrint("Error during sync: $e");
  }
}
