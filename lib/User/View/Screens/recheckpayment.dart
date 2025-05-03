import 'package:flutter/material.dart';

import 'Home/paymentsuccess.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout (3/4)"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rider Details
            _buildSectionTitle("Rider Details"),
            _buildBoldText("Adhi", "(Rider ID: Jack01)"),
            _buildDetailRow("Contact:", "8921669037"),
            const SizedBox(height: 8),

            // Delivery Time Box
            _buildDeliveryTimeBox("08:43"),
            const Divider(height: 30),

            // Customer Details (Modified)
            _buildSectionTitle("Customer Details"),
            _buildParkingFloorRow(),
            _buildDetailRow("Owner Name", "KAVYA KRISHNAN K K"),
            _buildDetailRow("Mobile Number", "8921669037"),
            _buildDetailRow("Vehicle Number", "KL 57 W 417"),
            _buildDetailRow("Vehicle Name", "Tata Harrier"),
            _buildDetailRow("Vehicle Color", "Black"),
            const Divider(height: 30),

            // Payment Details
            _buildSectionTitle("Payment Details"),
            _buildDetailRow("Delivery Charges", "₹ 200"),
            _buildDetailRow("Total", "₹ 200"),

            const Spacer(), // Pushes the button to the bottom

            // Complete Payment Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentSuccessfulScreen()),
            );
            },child: const Text(
                  "Complete Payment",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Rider Name with ID
  Widget _buildBoldText(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // Rider Contact & Payment Details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Parking Floor and Pillar Row
  Widget _buildParkingFloorRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Parking floor\nand pillar",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Row(
            children: [
              _buildSmallButton("Ground"),
              const SizedBox(width: 6),
              _buildSmallButton("H01"),
            ],
          ),
        ],
      ),
    );
  }

  // Small Button (For Ground & H01)
  Widget _buildSmallButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  // Delivery Time Box
  Widget _buildDeliveryTimeBox(String time) {
    return Row(
      children: [
        const Text("Delivery Time:", style: TextStyle(fontSize: 14, color: Colors.black54)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(time, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
