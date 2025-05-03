import 'package:flutter/material.dart';

import '../../../../../Widgets/Constants/colors.dart';
import 'AdminAllorders.dart';
import 'AdminCompleteOrder.dart';
import 'Admininprogress.dart';



class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Adminallorderswrapper(),
                  AdminInprogressOrderswrapper(),
                  AdminCompleteOrderswrapper(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Hello,", style: TextStyle(fontSize: 22)),
            Text("Good Morning Team!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
              "Unlock insights, track growth, and manage performance effortlessly.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor:defaultBlue,
      unselectedLabelColor: Colors.black,
      indicatorColor: defaultBlue,
      isScrollable: true,
      tabs: const [
        Tab(text: "Pending Orders"),
        Tab(text: "Inprogress Orders"),
        Tab(text: "Complete Orders"),
      ],
    );
  }

}
