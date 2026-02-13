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

      // Convert JSON list to Model list
      pointPacks.value = snapshot.docs
          .map((doc) => PointPackModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Could not load packages");
    } finally {
      isLoading(false);
    }
  }

  PointPackModel? get selectedPack =>
      selectedIndex.value == -1 ? null : pointPacks[selectedIndex.value];
}