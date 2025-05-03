// import 'package:flutter/material.dart';
//
// import '../../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
// import '../../../../../Widgets/Constants/Loading.dart';
// import '../../BuddyBottomNav/BuddyBottomnav.dart';
// import 'Admin/view/Auth/Admin_Login.dart';
// import 'Admin/view/Sreens/Report/admin_report.dart';
// import 'Admin/view/Sreens/Usermanagement/Shop/Edit_accepted_shop.dart';
// import 'Buddy/View/Screen/Home/activedelivery/BuddyActiveDeliveryPage.dart';
// import 'Buddy/View/Screen/Home/Buddy_Assigntime.dart';
// import 'Buddy/View/Screen/Home/Buddy_completedelivery.dart';
// import 'Buddy/View/Screen/Home/Buddy_completedeliveryfirstpage.dart';
// import 'Buddy/View/Screen/Home/Buddy_scan.dart';
// import 'Buddy/View/Screen/Auth/buddy_signup_page.dart';
// import 'Buddy/View/Screen/Home/Profile/Ridertermsandconditions.dart';
// import 'Buddy/View/Screen/Home/home.dart';
// import 'Shop/Bottomnav/Shop_Bottom.dart';
// import 'Shop/View/Screens/Home/Order/Checkout.dart';
// import 'Shop/View/Screens/Home/shop_home_page.dart';
// import 'Shop/View/Screens/Home/Order/Shop_Userselectparking.dart';
// import 'Shop/View/Screens/auth/Shopsplashview.dart';
// import 'Shop/View/Screens/auth/shop_login.dart';
// import 'Shop/View/Screens/auth/shop_signup_page.dart';
// import 'Shop/View/Screens/paymentsuccessful.dart';
// import 'Shop/View/Screens/shop_active_delivery.dart';
// import 'Shop/View/Screens/Home/Order/shop_assign_buddy.dart';
//
// import 'Shop/View/Screens/Home/Order/shop_payment_successfull.dart';
// import 'Shop/View/Screens/Home/Order/shop_select_parking.dart';
// import 'Shop/View/Screens/ordersstatus/shoporderhistory.dart';
// import 'User/View/Screens/Bottomnav/Bottom.dart';
// import 'User/View/Screens/Bottomnav/Bottomnav.dart';
// import 'User/View/Screens/Home/Profile/Termsandconditions.dart';
// import 'User/View/Screens/Home/Profile/privacyandpolicy.dart';
// import 'User/View/Screens/Home/User_Home_page.dart';
// import 'User/View/Screens/Home/User_shop.dart';
// import 'User/View/Screens/Home/listinvoices.dart';
// import 'User/View/Screens/Home/paymentsuccess.dart';
// import 'User/View/Screens/Home/Profile/profile.dart';
// import 'User/View/Screens/Home/scan.dart';
// import 'User/View/Screens/Splash/onboardingpage_one.dart';
// import 'User/View/Screens/Splash/onboardingpage_three.dart';
// import 'User/View/Screens/Splash/onboardingpage_two.dart';
// import 'User/View/Screens/Splash/splash_screen.dart';
// import 'User/View/Screens/auth/User_login_page.dart';
// import 'User/View/Screens/auth/forgotpassword.dart';
// import 'User/View/Screens/auth/user_checkmail_page.dart';
// import 'User/View/Screens/completedelivery.dart';
// import 'User/View/Screens/myorders.dart';
// import 'User/View/Screens/notification.dart';
// import 'User/View/Screens/orderhistory.dart';
// import 'User/View/Screens/recheckpayment.dart';
//
//
// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/services.dart';
//
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../../Controller/bloc/Orderbloc/order_bloc.dart';
// import '../../../../Widget/constands/Loading.dart';
// import '../Btm_Nav/Driver_Btm_Nav.dart';
//
// // import 'package:url_launcher/url_launcher.dart';
//
// class BuddyQRScanPage extends StatefulWidget {
//   const BuddyQRScanPage({super.key});
//
//   @override
//   State<BuddyQRScanPage> createState() => _BuddyQRScanPageState();
// }
//
// class _BuddyQRScanPageState extends State<BuddyQRScanPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   String scannedData = "";
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Blurred Background Image
//           ImageFiltered(
//             imageFilter:
//             ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust blur intensity
//             child: Image.asset(
//               "assets/scanner/qrimageblur.png", // Replace with your image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           // QR Scanner
//           // QRView(
//           //   key: qrKey,
//           //   onQRViewCreated: _onQRViewCreated,
//           //   overlay: QrScannerOverlayShape(
//           //     borderColor: Colors.white,
//           //     borderRadius: 12,
//           //     borderLength: 30,
//           //     borderWidth: 8,
//           //     cutOutSize: 250,
//           //   ),
//           // ),
//
//           // Blurred Background Overlay
//           Container(
//             color: Colors.black.withOpacity(0.5),
//           ),
//
//           // Centered QR Code with Text
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Instruction Text
//                 const Text(
//                   "Scan the QR code to",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 const Text(
//                   "complete the delivery",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // QR Code Placeholder (Optional)
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Image.asset(
//                             "assets/scanner/qr.png",
//                             // Update with actual QR image path
//                             height: 180,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 // Scan Button
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return Page2();
//                       },
//                     ));
//                   },
//                   icon: const Icon(Icons.qr_code_scanner_rounded),
//                   label: const Text("Scan"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 45, vertical: 22),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Page2 extends StatefulWidget {
//   const Page2({super.key});
//
//   @override
//   State<Page2> createState() => _Page2State();
// }
//
// class _Page2State extends State<Page2> {
//   bool _hasPermission = false;
//   String _barcodeData = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();
//   }
//
//   Future<void> _checkPermissions() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//       status = await Permission.camera.request();
//     }
//
//     if (status.isGranted) {
//       setState(() {
//         _hasPermission = true;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please turn on permission in settings'),
//           backgroundColor: Colors.red, // optional
//           duration: Duration(seconds: 3), // optional
//         ),
//       );
//     }
//   }
//
//   void _onBarcodeDetected(BarcodeCapture capture) {
//     setState(() {
//       if (capture.barcodes.isNotEmpty) {
//         _barcodeData = capture.barcodes.first.rawValue ?? "No Data Found";
//       }
//     });
//   }
//   bool _isURL(String text) {
//     const urlPattern =
//         r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$';
//     return RegExp(urlPattern).hasMatch(text);
//   }
//
//   // Future<void> _launchURL(String url) async {
//   //   Uri uri = Uri.parse(url);
//   //   // if (await canLaunchUrlString(url)) {
//   //   launchUrl(uri, mode: LaunchMode.externalApplication);
//   //   // } else {
//   //   //   Get.snackbar('Error', 'Could not launch $url');
//   //   //   print('Could not launch $url');
//   //   // }
//   // }
//
//   // Future<void> testLaunch() async {
//   //   const url = 'https://www.google.com';
//   //   Uri uri = Uri.parse(url);
//   //   if (await canLaunchUrl(uri)) {
//   //     await launchUrl(uri);
//   //   } else {
//   //     print("Could not launch $url");
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.transparent),
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: _hasPermission
//             ? _barcodeData.isEmpty
//             ? SizedBox(
//           width: 300,
//           height: 300,
//           child: MobileScanner(onDetect: _onBarcodeDetected),
//         )
//             : BlocProvider(
//           create: (context) => OrderBloc()
//             ..add(Deliverd_scann_event(orderid: _barcodeData)),
//           child: BlocConsumer<OrderBloc, OrderState>(
//             listener: (context, state) {
//               if (state is Scannersuccess) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DeliverySuccessPage(),
//                   ),
//                 );
//               }
//             },
//             builder: (context, state) {
//               if (state is OrderLoading) {
//                 return const Center(child: Loading_Widget());
//               } else if (state is Deliverderror) {
//                 return Center(
//                   child: Text(
//                     state.error.toString(),
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 );
//               } else if (state is Ordersloaded) {
//                 final Orders = state.Orders;
//
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Image.asset(
//                           'assets/Buddy/Orderdeliverd.png', // Replace with your image path
//                           height: 300,
//                           width: 200,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           "Order Update",
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Order Details Card
//                       Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               _buildInfoRow("Order ID",
//                                   Orders.orderid.toString()),
//                               _buildInfoRow("Username",
//                                   Orders.Ownername.toString()),
//                               _buildInfoRow("Shop Name",
//                                   Orders.shopname.toString()),
//                               _buildInfoRow(
//                                   "Amount", "₹ ${Orders.payment}"),
//                               _buildInfoRow("Delivery Time",
//                                   Orders.time),
//                               _buildInfoRow("Status", Orders.status),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       // Delivery Button
//                       BlocConsumer<OrderBloc, OrderState>(
//                         listener: (context, state) {
//                           if (state is Scannersuccess) {
//                             Navigator.push(context, MaterialPageRoute(
//                               builder: (context) => DeliverySuccessPage(),
//                             ));
//                           }
//                         },
//                         builder: (context, state) {
//                           return GestureDetector(
//                             onTap: () {
//                               context.read<OrderBloc>().add(
//                                 Deliverd_scann_event(orderid: _barcodeData),
//                               );
//                             },
//                             child: Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.green.withOpacity(0.4),
//                                     spreadRadius: 1,
//                                     blurRadius: 6,
//                                     offset: Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                               alignment: Alignment.center,
//                               child: state is scanndeliverdLoading
//                                   ? Loading_Widget()
//                                   : Text(
//                                 "Click to Delivered",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }
//
//               return const SizedBox();
//             },
//           ),
//         )
//             : const Text(
//           'Camera permission is required to scan QR codes.',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               "$title:",
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DeliverySuccessPage extends StatefulWidget {
//   const DeliverySuccessPage({super.key});
//
//   @override
//   State<DeliverySuccessPage> createState() => _DeliverySuccessPageState();
// }
//
// class _DeliverySuccessPageState extends State<DeliverySuccessPage> {
//   int _countdown = 5;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_countdown > 1) {
//         setState(() {
//           _countdown--;
//         });
//       } else {
//         timer.cancel();
//         _navigateToNextPage();
//       }
//     });
//   }
//
//   void _navigateToNextPage() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//           const BottomNavwrapper()), // Replace with your actual page
//     );
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
//               const SizedBox(height: 20),
//               const Text(
//                 'Successfully Completed',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Your item has been delivered.\nThank you for shopping with us!',
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               Text(
//                 'Redirecting in $_countdown seconds...',
//                 style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Dummy HomePage
