// import 'package:flutter/material.dart';
//
// class RiderStatusScreen extends StatefulWidget {
//   const RiderStatusScreen({super.key});
//
//   @override
//   State<RiderStatusScreen> createState() => _RiderStatusScreenState();
// }
//
// class _RiderStatusScreenState extends State<RiderStatusScreen> {
//   bool isAvailable = true; // Rider's current status
//
//   void _showStatusDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         bool tempStatus = isAvailable; // Temporary status inside popup
//         return AlertDialog(
//           title: const Text("Change Status"),
//           content: StatefulBuilder(
//             builder: (context, setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(tempStatus ? "Available" : "Unavailable",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: tempStatus ? Colors.green : Colors.red,
//                       )),
//                   Switch(
//                     value: tempStatus,
//                     activeColor: Colors.green,
//                     inactiveThumbColor: Colors.red,
//                     onChanged: (value) {
//                       setState(() {
//                         tempStatus = value;
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   isAvailable = tempStatus;
//                 });
//                 Navigator.pop(context); // Close dialog
//                 // Here, you can also fire a BLoC event to update status in backend
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Rider Status")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _showStatusDialog,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: isAvailable ? Colors.green : Colors.red,
//             minimumSize: const Size(200, 50),
//           ),
//           child: Text(
//             isAvailable ? "Available" : "Unavailable",
//             style: const TextStyle(color: Colors.white, fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart'; // For PDF viewing
// import 'package:file_picker/file_picker.dart';
//
// class FileDisplayPage extends StatefulWidget {
//   @override
//   _FileDisplayPageState createState() => _FileDisplayPageState();
// }
//
// class _FileDisplayPageState extends State<FileDisplayPage> {
//   String? _selectedFileName;
//   String? _selectedFilePath;
//
//   // To check if it's an image or PDF
//   bool isImage(String filePath) {
//     return filePath.toLowerCase().endsWith('.jpg') ||
//         filePath.toLowerCase().endsWith('.png') ||
//         filePath.toLowerCase().endsWith('.jpeg');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("File Upload Example"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 FilePickerResult? result = await FilePicker.platform.pickFiles(
//                   type: FileType.custom,
//                   allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
//                 );
//
//                 if (result != null) {
//                   PlatformFile file = result.files.first;
//                   setState(() {
//                     _selectedFileName = file.name;
//                     _selectedFilePath = file.path;
//                   });
//                   print('Selected file path: ${file.path}');
//                 }
//               },
//               child: Text("Pick File"),
//             ),
//             SizedBox(height: 20),
//             _selectedFilePath == null
//                 ? Text("No file selected.")
//                 : isImage(_selectedFilePath!)
//                 ? Image.file(File(_selectedFilePath!)) // For image files
//                 : PDFView( // For PDF files
//               filePath: _selectedFilePath!,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
