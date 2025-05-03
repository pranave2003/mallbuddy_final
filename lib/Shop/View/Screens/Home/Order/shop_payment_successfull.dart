import 'package:flutter/material.dart';


import '../../../../Bottomnav/Shop_Bottom.dart';

class ShopPaymentSuccessfulScreen extends StatelessWidget {
  const ShopPaymentSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of the screen
      body: SafeArea(
        child: Center(
          child: Container(
            width: 340, // Fixed width for better design
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Payment Icon
                // Payment Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: 125, // Set width
                    height: 125, // Set height
                    child:
                        Image.asset("assets/success.png", fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 16),

                // Payment Successful Text
                const Text(
                  "Booking Confirmed",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "successfully!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // Payment Details Container
                // Container(
                //   width: double.infinity, // Expand to full width
                //   padding: const EdgeInsets.all(20), // Increased padding
                //   constraints: const BoxConstraints(
                //     minHeight: 400, // Ensures minimum height
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.white, // White background
                //     borderRadius: BorderRadius.circular(15), // Rounded corners
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.shade300, // Light gray shadow
                //         blurRadius: 6, // Increased blur
                //         spreadRadius: 2, // Increased spread
                //         offset: const Offset(0, 4), // Slight downward shadow
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // Booking Methods Title
                //       const Text(
                //         "Booking Methods",
                //         style: TextStyle(
                //           fontSize: 18, // Slightly increased font size
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       const SizedBox(height: 12),
                //
                //       _buildPaymentDetail("Booking ID", "71"),
                //       _buildPaymentDetail("Booking ID", "Adhi0123"),
                //       _buildPaymentDetail("Order ID", "1234 4567 8901"),
                //       _buildPaymentDetail("Date & Time", "29/09/25, 08:43 am"),
                //       _buildPaymentDetail("Total", "₹200"),
                //
                //       const SizedBox(height: 12),
                //
                //       // Status Row
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const Text(
                //             "Status",
                //             style: TextStyle(
                //                 fontSize: 14, fontWeight: FontWeight.bold),
                //           ),
                //           Container(
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 14,
                //                 vertical: 8), // Increased padding
                //             decoration: BoxDecoration(
                //               color: Colors.blue[100],
                //               borderRadius: BorderRadius.circular(20),
                //             ),
                //             child: const Text(
                //               "Success",
                //               style: TextStyle(
                //                 color: Colors.blue,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 16, // Slightly increased font size
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 35), // Increased spacing
                //
                //       // Thank You Message
                //       const Center(
                //         child: Text(
                //           "Thank you for shopping with us!",
                //           style: TextStyle(color: Colors.grey, fontSize: 16),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 40),

                // Buttons Row
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ShopBottomnavwrapper();
                            },
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.black),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 22),
                        ),
                        child: const Text(
                          "Back to Home",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () {},
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: defaultBlue,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 18, horizontal: 22),
                      //   ),
                      //   child: const Text(
                      //     "Share to User",
                      //     style: TextStyle(color: Colors.black, fontSize: 16),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget for Payment Details
  Widget _buildPaymentDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
