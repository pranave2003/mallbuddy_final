import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../Widgets/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../BuddyBottomNav/BuddyBottomnav.dart';
// import 'package:url_launcher/url_launcher.dart';

class BuddyQRScanPage extends StatefulWidget {
  const BuddyQRScanPage({super.key});

  @override
  State<BuddyQRScanPage> createState() => _BuddyQRScanPageState();
}

class _BuddyQRScanPageState extends State<BuddyQRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String scannedData = "";

  @override
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
                            "assets/scanner/qr.png",
                            // Update with actual QR image path
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Page2();
                      },
                    ));
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

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool _hasPermission = false;
  String _barcodeData = '';

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      setState(() {
        _hasPermission = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please turn on permission in settings'),
          backgroundColor: Colors.red, // optional
          duration: Duration(seconds: 3), // optional
        ),
      );
    }
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    setState(() {
      if (capture.barcodes.isNotEmpty) {
        _barcodeData = capture.barcodes.first.rawValue ?? "No Data Found";
      }
    });
  }

  bool _isURL(String text) {
    const urlPattern =
        r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$';
    return RegExp(urlPattern).hasMatch(text);
  }

  // Future<void> _launchURL(String url) async {
  //   Uri uri = Uri.parse(url);
  //   // if (await canLaunchUrlString(url)) {
  //   launchUrl(uri, mode: LaunchMode.externalApplication);
  //   // } else {
  //   //   Get.snackbar('Error', 'Could not launch $url');
  //   //   print('Could not launch $url');
  //   // }
  // }

  // Future<void> testLaunch() async {
  //   const url = 'https://www.google.com';
  //   Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     print("Could not launch $url");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: Colors.transparent,
      // floatingActionButton:
      // _barcodeData.isNotEmpty
      //     ? Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     NextPageButton(
      //       text: 'Scan again',
      //       icon: const Icon(Icons.qr_code_2_rounded),
      //       goto: () {
      //         setState(() {
      //           _barcodeData = ''; // Clear the scanned data
      //         });
      //       },
      //       heroTag: 'scanAgainHero',
      //     ),
      //     const SizedBox(width: 10),
      //     NextPageButton(
      //       text: 'Copy text',
      //       icon: const Icon(Icons.qr_code_2_rounded),
      //       goto: () {
      //         Clipboard.setData(ClipboardData(text: _barcodeData)).then(
      //               (value) => Get.snackbar(
      //             'Copied text',
      //             'Text copied successfully',
      //           ),
      //         );
      //       },
      //       heroTag: 'copyTextHero',
      //     ),
      //   ],
      // )
      //     : Container(),
      body: Center(
        child: _hasPermission
            ? _barcodeData.isEmpty
                ? SizedBox(
                    width: 300,
                    height: 300,
                    child: MobileScanner(onDetect: _onBarcodeDetected),
                  )
        :Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/Buddy/Orderdeliverd.png', // Replace with your image path
                  height: 400,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
              // SizedBox(height: 6),
              Center(
                child: Text(
                  "Order Update",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Order ID : $_barcodeData",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),

              // Delivery Button
              SizedBox(height: 20),
              BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is Scannersuccess) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DeliverySuccessPage(),
                    ));
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<OrderBloc>().add(
                        Deliverd_scann_event(orderid: _barcodeData),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: state is scanndeliverdLoading
                          ? Loading_Widget()
                          : Text(
                        "Click to Delivered",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
            : const Text(
                'Camera permission is required to scan QR codes.',
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}

class DeliverySuccessPage extends StatefulWidget {
  const DeliverySuccessPage({super.key});

  @override
  State<DeliverySuccessPage> createState() => _DeliverySuccessPageState();
}

class _DeliverySuccessPageState extends State<DeliverySuccessPage> {
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        _navigateToNextPage();
      }
    });
  }

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const BottomNavwrapper()), // Replace with your actual page
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              const Text(
                'Delivered Successfully!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your item has been delivered.\nThank you for shopping with us!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'Redirecting in $_countdown seconds...',
                style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy HomePage
