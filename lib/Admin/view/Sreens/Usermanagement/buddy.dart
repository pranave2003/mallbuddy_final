import 'package:flutter/material.dart';

import '../../../../Widgets/Constants/colors.dart';

import 'Buudy/Accepeted_Buddy.dart';
import 'Buudy/Registered_Buddy.dart';
import 'Buudy/Rejected_Buddy.dart';

class AdminBuddy extends StatefulWidget {
  const AdminBuddy({super.key});

  @override
  State<AdminBuddy> createState() => _AdminBuddyState();
}

class _AdminBuddyState extends State<AdminBuddy>
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
                  RegisterdBuddywrapper(),
                  AdminAcceptedwrapper(),
                  BuddyRejectedtedwrapper(),
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
        Tab(text: "Registered Buddy"),
        Tab(text: "Accepted Buddy"),
        Tab(text: "Rejected Buddy"),
      ],
    );
  }

}
