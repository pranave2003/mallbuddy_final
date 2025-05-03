 import 'package:flutter/material.dart';

// class AdminAddRiderPage extends StatefulWidget {
//   @override
//   _AdminAddRiderPageState createState() => _AdminAddRiderPageState();
// }
//
// class _AdminAddRiderPageState extends State<AdminAddRiderPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   String? selectedFloor;
//   TimeOfDay? selectedTime;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             const SizedBox(height: 20),
//             _buildTabBar(),
//             const SizedBox(height: 20),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildAllRiderView(),
//                   _buildAddRiderForm(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         // Column(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: const [
//         //     Text("Hello,", style: TextStyle(fontSize: 22, color: Colors.white)),
//         //     Text("Good Morning Team!",
//         //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
//         //     SizedBox(height: 5),
//         //     Text("Unlock insights, track growth, and manage performance effortlessly.",
//         //         style: TextStyle(fontSize: 16, color: Colors.grey)),
//         //   ],
//         // ),
//         Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.search, color: Colors.white),
//               onPressed: () {},
//             ),
//             Container(
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 children: const [
//                   CircleAvatar(
//                     backgroundImage: AssetImage('assets/admin.png'),
//                     radius: 18,
//                   ),
//                   SizedBox(width: 8),
//                   Text("Admin", style: TextStyle(fontSize: 16, color: Colors.black)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTabBar() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
//       ),
//       child: TabBar(
//         controller: _tabController,
//         labelColor: Colors.blue,
//         unselectedLabelColor: Colors.black,
//         indicatorColor: Colors.blue,
//         tabs: const [
//           Tab(text: "All Rider"),
//           Tab(text: "Add Rider"),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAllRiderView() {
//     return const Center(child: Text("All Riders List", style: TextStyle(fontSize: 18)));
//   }
//
//   Widget _buildAddRiderForm() {
//     return Center(
//       child: Container(
//         width: 600,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//             )
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInputField("Rider Name", "Enter rider name",),
//             const SizedBox(height: 10),
//             _buildTimePicker(),
//             const SizedBox(height: 10),
//             _buildDropdownField(),
//             const SizedBox(height: 20),
//             _buildSubmitButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInputField(String label, String hint) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         TextField(
//           decoration: InputDecoration(
//             hintText: hint,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//             filled: true,
//             fillColor: Colors.grey.shade200,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTimePicker() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Select Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         GestureDetector(
//           onTap: _selectTime,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: Colors.grey),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(selectedTime != null
//                     ? "${selectedTime!.hour}:${selectedTime!.minute}"
//                     : "Select time"),
//                 const Icon(Icons.refresh, color: Colors.black),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _selectTime() async {
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime != null) {
//       setState(() {
//         selectedTime = pickedTime;
//       });
//     }
//   }
//
//   Widget _buildDropdownField() {
//     List<String> floors = ["Ground Floor", "First Floor", "Second Floor", "Third Floor"];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Select Floor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 5),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.grey.shade200,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//           ),
//           value: selectedFloor,
//           hint: const Text("Select floor"),
//           items: floors.map((floor) {
//             return DropdownMenuItem<String>(
//               value: floor,
//               child: Text(floor),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedFloor = value;
//             });
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSubmitButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle form submission
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           padding: const EdgeInsets.symmetric(vertical: 14),
//         ),
//         child: const Text("Add Rider", style: TextStyle(fontSize: 18, color: Colors.white)),
//       ),
//     );
//   }
// }
