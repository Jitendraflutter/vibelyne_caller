import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../features/home/model/banner_model.dart';

class BannerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var currentBanner = Rxn<BannerModel>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    listenToBanners(); // Use a listener instead of a one-time fetch
  }

  void listenToBanners() {
    isLoading(true);
    // .snapshots() provides a real-time stream of your database
    _firestore
        .collection('banners')
        .where('is_active', isEqualTo: true)
        .snapshots()
        .listen(
          (snapshot) {
            if (snapshot.docs.isNotEmpty) {
              var doc = snapshot.docs.first;
              currentBanner.value = BannerModel.fromFirestore(
                doc.data(),
                doc.id,
              );
            } else {
              // If no banners are true, clear the current banner so the widget disappears
              currentBanner.value = null;
            }
            isLoading(false);
          },
          onError: (e) {
            print("Error listening to banners: $e");
            isLoading(false);
          },
        );
  }
}
