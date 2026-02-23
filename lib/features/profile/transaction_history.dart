import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:voicly/controller/transcation_controller.dart';
import 'package:voicly/widget/screen_wrapper.dart'; // Add this to pubspec.yaml if you don't have it!

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});

  // Initialize the controller
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: "Transaction History",
      visibleAppBar: true,

      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.transactions.isEmpty) {
          return Center(
            child: Text(
              "No transactions found.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final data = controller.transactions[index];
            return _buildTransactionCard(data);
          },
        );
      }),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> data) {
    // Safely parse the timestamp
    DateTime date;
    if (data['timestamp'] != null) {
      date = (data['timestamp'] as Timestamp).toDate();
    } else {
      date = DateTime.now();
    }

    // Format the date (e.g., "Feb 24, 2026")
    String formattedDate = DateFormat('MMM dd, yyyy , hh:mm a').format(date);

    return Card(
      color: Colors.white10,
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "+ ${data['pointsAdded'] ?? 0} Points",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "ID: ${data['transactionId'] ?? 'N/A'}",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),

            // Right Side: Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹${data['amount'] ?? 0}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    (data['status'] ?? 'Success').toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
