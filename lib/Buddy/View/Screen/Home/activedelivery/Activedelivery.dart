import 'package:flutter/material.dart';


import '../../../../../Widgets/Constants/colors.dart';
import 'Acceptdelivery.dart';
import 'BuddyActiveDeliveryPage.dart';


late TabController _tabController;

class BUddy_Active_delivery extends StatefulWidget {
  const BUddy_Active_delivery({super.key});

  @override
  State<BUddy_Active_delivery> createState() => _BUddy_Active_deliveryState();
}

class _BUddy_Active_deliveryState extends State<BUddy_Active_delivery>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // FIXED: length = 4
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header

            // TabBar
            TabBar(
              controller: _tabController, // FIXED: Using only one TabController
              isScrollable: true,
              indicatorColor: defaultBlue,
              indicatorWeight: 3,
              labelColor: defaultBlue,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: "Active Delivery"),
                Tab(text: "Accepted Delivery"),
              ],
            ),

            const SizedBox(height: 10),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics:
                const BouncingScrollPhysics(), // FIXED: Ensures smooth scrolling
                children: [
                  BuddyActiveDeliverywrapper(),
                  BuddyAcceptdeliverywrapper(),

                  // AdminAcceptedwrapper(),
                  // AdminRejectedWrapper(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
