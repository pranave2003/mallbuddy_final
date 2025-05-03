import 'package:flutter/material.dart';




class CompleteDeliveryScreen extends StatelessWidget {
  const CompleteDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Complete Delivery",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // QR Code

            const SizedBox(height: 10),
            const Text(
              "Order ID #12345",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Order Details
            _buildDetailRow("Name", "Kavya Krishnan K K"),
            _buildDetailRow("Zara Invoice 1", "#012"),
            _buildDetailRow("Zara Invoice 1", "#012"),
            _buildDetailRow("Zara Invoice 1", "#012"),
            _buildDetailRow("Delivery Time", "10:00am"),
            _buildDetailRow("Delivery Location", "Ground Floor, H01"),
            _buildDetailRow("Status", "Completed", isStatus: true),
          ],
        ),
      ),
    );
  }

  // Row Widget for Order Details
  Widget _buildDetailRow(String title, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          isStatus
              ? Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          )
              : Text(
            value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
