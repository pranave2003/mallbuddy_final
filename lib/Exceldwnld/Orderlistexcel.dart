// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:excel/excel.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ExportOrdersScreen extends StatefulWidget {
//   @override
//   _ExportOrdersScreenState createState() => _ExportOrdersScreenState();
// }
//
// class _ExportOrdersScreenState extends State<ExportOrdersScreen> {
//   bool isExporting = false;
//   String statusMessage = "";
//
//   // Step 1: Fetch Orders from Firebase
//   Future<List<Map<String, dynamic>>> fetchOrders() async {
//     final snapshot = await FirebaseFirestore.instance.collection('orders').get();
//     return snapshot.docs.map((doc) => doc.data()).toLisat();
//   }
//
//   // Step 2–5: Export to Excel, Save Locally, Ask Permission
//   Future<void> exportOrdersToExcel() async {
//     setState(() {
//       isExporting = true;
//       statusMessage = "Exporting...";
//     });
//
//     // Request permission
//     final status = await Permission.storage.request();
//     if (!status.isGranted) {
//       setState(() {
//         isExporting = false;
//         statusMessage = "Storage permission denied.";
//       });
//       return;
//     }
//
//     try {
//       // Fetch orders from Firestore
//       List<Map<String, dynamic>> orders = await fetchOrders();
//
//       if (orders.isEmpty) {
//         setState(() {
//           isExporting = false;
//           statusMessage = "No orders to export.";
//         });
//         return;
//       }
//
//       // Create Excel
//       var excel = Excel.createExcel();
//       Sheet sheet = excel['Orders'];
//
//       // Add column headers
//       List<String> headers = orders[0].keys.toList();
//       sheet.appendRow(headers);
//
//       // Add order rows
//       for (var order in orders) {
//         List<dynamic> row = [];
//         for (var header in headers) {
//           row.add(order[header]);
//         }
//         sheet.appendRow(row);
//       }
//
//       // Get save location
//       Directory? directory = await getExternalStorageDirectory();
//       String path = "${directory!.path}/orders.xlsx";
//
//       // Save file
//       File file = File(path)
//         ..createSync(recursive: true)
//         ..writeAsBytesSync(excel.encode()!);
//
//       setState(() {
//         isExporting = false;
//         statusMessage = "Excel file saved at:\n$path";
//       });
//     } catch (e) {
//       setState(() {
//         isExporting = false;
//         statusMessage = "Error: ${e.toString()}";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Export Orders to Excel'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               isExporting
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                 onPressed: exportOrdersToExcel,
//                 child: Text("Export Orders"),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 statusMessage,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: Colors.black87),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
