import 'package:flutter/material.dart';

import '../../../../Widgets/Constants/colors.dart';
import 'floorwiseFees/Firstfloor.dart';
import 'floorwiseFees/SecondFloor.dart';
import 'floorwiseFees/Thirdfloor.dart';
import 'floorwiseFees/fifthfloor.dart';
import 'floorwiseFees/fourthfloor.dart';
import 'floorwiseFees/groundfloor.dart';

class AdminDeliveryFees extends StatefulWidget {
  const AdminDeliveryFees({super.key});

  @override
  State<AdminDeliveryFees> createState() => _AdminDeliveryFeesState();
}

class _AdminDeliveryFeesState extends State<AdminDeliveryFees> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};





  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: Greeting, Search, and Admin Profile
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hello,", style: TextStyle(fontSize: 22)),
                    Text(
                      "Good Morning Team!",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Unlock insights, track growth, and manage performance effortlessly.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 0.5, color: Colors.grey),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 0.5, color: Colors.grey),
                      ),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/profile/girl.png'),
                          ),
                          SizedBox(width: 10),
                          Text("Admin", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Main Content: Delivery Fees Card
            Expanded(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery Fees",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // TabBar
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: defaultBlue,
                        indicatorWeight: 3,
                        labelColor: defaultBlue,
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(text: "Ground Floor"),
                          Tab(text: "First Floor"),
                          Tab(text: "Second Floor"),
                          Tab(text: "Third Floor"),
                          Tab(text: "Fourth Floor"),
                          // Tab(text: "Fifth Floor"),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Assign Fees Button
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.black,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //     ),
                      //     child: const Text("Assign Fees"),
                      //   ),
                      // ),

                      // Tab Views with DataTable
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics:
                          const BouncingScrollPhysics(), // FIXED: Ensures smooth scrolling
                          children: [
                            Buddyfeesgroundfloorwrapper(),
                            Buddyfeesfirstfloorwrapper(),
                            BuddyfeesSecondfloorwrapper(),
                            BuddyfeesThirdfloorwrapper(),
                            BuddyfeesFourthfloorwrapper(),
                            // Buddyfeesfifthfloorwrapper(),
                          ],                       ),
                      ),
            ])) ],
                  ),
                ),



    );


  }

  // Function to build DataTable
  // Function to build DataTable
  // Widget _buildDataTable() {
  //   return Expanded( // Ensures the DataTable fills available space
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.vertical, // Allow vertical scrolling
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal, // Allow horizontal scrolling if needed
  //         child: DataTable(
  //           columnSpacing: 140,
  //           columns: const [
  //             DataColumn(label: Text("Sl No", style: TextStyle(fontWeight: FontWeight.bold))),
  //             DataColumn(label: Text("Rider Name", style: TextStyle(fontWeight: FontWeight.bold))),
  //             DataColumn(label: Text("Rider ID", style: TextStyle(fontWeight: FontWeight.bold))),
  //             DataColumn(label: Text("Total Delivery", style: TextStyle(fontWeight: FontWeight.bold))),
  //             DataColumn(label: Text("Delivery Fees", style: TextStyle(fontWeight: FontWeight.bold))),
  //             DataColumn(label: Text("Action", style: TextStyle(fontWeight: FontWeight.bold))),
  //           ],
  //           rows: List.generate(
  //             5,
  //                 (index) => DataRow(
  //               cells: [
  //                 DataCell(Text((index + 1).toString())),
  //                 DataCell(Text(index == 0 ? "Adhi" : "Kiran")),
  //                 DataCell(Text("#123")),
  //                 DataCell(Text("5")),
  //                 DataCell(Text("200")),
  //                 DataCell(
  //                   ElevatedButton(
  //                     onPressed: () {},
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.white,
  //                       side: const BorderSide(color: Colors.green),
  //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //                     ),
  //                     child: const Text("Edit", style: TextStyle(color: Colors.green)),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
