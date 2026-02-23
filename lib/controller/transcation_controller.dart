import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observable list to hold the transactions
  var transactions = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserTransactions();
  }

  void fetchUserTransactions() async {
    try {
      isLoading(true);
      String? uid = _auth.currentUser?.uid;

      if (uid == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      // 🟢 Query Firestore: Get only THIS user's transactions, newest first
      QuerySnapshot snapshot = await _firestore
          .collection('transactions')
          .where('uid', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .get();

      // Map the documents to our observable list
      transactions.value = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching transactions: $e");
      Get.snackbar("Error", "Could not load transaction history.");
    } finally {
      isLoading(false);
    }
  }
}
