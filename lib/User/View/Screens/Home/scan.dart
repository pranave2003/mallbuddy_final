import 'dart:ui';

import 'package:flutter/material.dart';


import '../../../../Widgets/Constants/colors.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String scannedData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred Background Image
          ImageFiltered(
            imageFilter:
                ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust blur intensity
            child: Image.asset(
              "assets/scanner/qrimageblur.png", // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // QR Scanner
          // QRView(
          //   key: qrKey,
          //   onQRViewCreated: _onQRViewCreated,
          //   overlay: QrScannerOverlayShape(
          //     borderColor: Colors.white,
          //     borderRadius: 12,
          //     borderLength: 30,
          //     borderWidth: 8,
          //     cutOutSize: 250,
          //   ),
          // ),

          // Blurred Background Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Centered QR Code with Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Instruction Text
                const Text(
                  "Scan the QR code to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  "complete the delivery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),

                // QR Code Placeholder (Optional)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            "assets/scanner/qr.png", // Update with actual QR image path
                            height: 180,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Scan Button
                ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: const Text("Scan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: defaultBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for QR Scanner Frame
