import 'package:flutter/material.dart';

class OrderQRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text(
        //   "payment successful",
        //   style: TextStyle(color: Colors.grey, fontSize: 14),
        // ),
        // backgroundColor: Colors.transparent,
        // elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Order QR Title**
            const Text(
              "Order QR",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 100),

            /// **QR Code Card**
            Card(
              color: Colors.white,

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// **QR Code Image**
                    Image.asset("assets/scanner/qr.png", width: 120, height: 120),

                    const SizedBox(height: 16),

                    /// **Order Details**
                    buildDetailRow("Booking ID", "71", isBookingID: true),

                    buildDetailRow("Order ID", "1234 4567 8901"),

                    buildDetailRow("Date & Time", "29/09/25, 08:43 am"),

                    buildDetailRow("Total", "₹200"),

                    /// **Status (Blue - Success)**
                    buildStatusRow("Status", "Success", Colors.blue),

                    /// **Delivery Status (Green - Delivered)**
                    buildStatusRow("Delivery Status", "Delivered", Colors.green),

                    const SizedBox(height: 10),

                    /// **Thank You Message**
                    const Text(
                      "Thank you for shopping with us!",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Reusable Row for Order Details**
  Widget buildDetailRow(String title, String value, {bool isBookingID = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        if (isBookingID) ...[
          const SizedBox(width: 5),
        ],
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// **Reusable Row for Status**
  Widget buildStatusRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: color, size: 16),
                const SizedBox(width: 5),
                Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w100)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
