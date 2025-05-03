import 'package:flutter/material.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../../../Model/User_Management/shop_model.dart';
import 'Shop/Accepted_shop_page.dart';
import 'Shop/Admin_Rejected_shop.dart';
import 'Shop/Registered_shop.dart';

late TabController _tabController;

class AdminShop extends StatefulWidget {
  const AdminShop({super.key});

  @override
  State<AdminShop> createState() => _AdminShopState();
}

class _AdminShopState extends State<AdminShop>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // FIXED: length = 4
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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hello,", style: TextStyle(fontSize: 22)),
                    Text("Good Morning Team!",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                      "Unlock insights, track growth, and manage performance effortlessly.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/profile/girl.png'),
                          ),
                          SizedBox(width: 10),
                          Text("Admin",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TabBar
            TabBar(
              controller: _tabController, // FIXED: Using only one TabController
              isScrollable: true,
              indicatorColor: defaultBlue,
              indicatorWeight: 3,
              labelColor: defaultBlue,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: "Registered Shop"),
                Tab(text: "Accepted Shop"),
                Tab(text: "Rejected Shop"),
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
                  PegisterdShopwrapper(),
                  AdminAcceptedwrapper(),
                  AdminRejectedWrapper(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
