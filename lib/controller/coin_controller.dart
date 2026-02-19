import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../features/coin/model/point_pack_model.dart';

class CoinController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = true.obs;
  var pointPacks = <PointPackModel>[].obs;
  var selectedIndex = (-1).obs;
  var selectedPaymentMethod = "UPI".obs;

  @override
  void onInit() {
    super.onInit();
    fetchPacks();
  }

  void fetchPacks() async {
    try {
      isLoading(true);
      var snapshot = await _firestore
          .collection('point_packs')
          .orderBy('display_order')
          .get();

      // 1. Load the data
      pointPacks.value = snapshot.docs
          .map((doc) => PointPackModel.fromFirestore(doc.data(), doc.id))
          .toList();

      // 2. Handle Auto-Selection from arguments
      // _handleInitialSelection();
    } catch (e) {
      Get.snackbar("Error", "Could not load packages");
    } finally {
      isLoading(false);
    }
  }

  void _handleInitialSelection() {
    if (Get.arguments != null && Get.arguments is int) {
      int passedIndex = Get.arguments;
      // Check bounds to prevent crashes
      if (passedIndex >= 0 && passedIndex < pointPacks.length) {
        selectedIndex.value = passedIndex;
      }
    }
  }

  PointPackModel? get selectedPack =>
      (selectedIndex.value >= 0 && selectedIndex.value < pointPacks.length)
      ? pointPacks[selectedIndex.value]
      : null;
}
