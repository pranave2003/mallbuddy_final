import 'package:flutter/material.dart';
import 'package:mallbuddyproject/User/View/Screens/status/Allordersscreen.dart';
import 'package:mallbuddyproject/User/View/Screens/status/canceledorders.dart';
import 'package:mallbuddyproject/User/View/Screens/status/deliveredorders.dart';
import 'package:mallbuddyproject/User/View/Screens/status/inprogress.dart';

import '../../../Widgets/Constants/colors.dart';



class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int activeTabIndex = 0;

  final List<Widget> tabs = [
    allordersScreenwrapper(),
    InProgressScreenwrapper(),
    deliverdordersscreenwrapper(),
    cancelledordersscreenwrapper(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My orders",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/profile/girl.png"),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTabButton("All orders", 0),
              _buildTabButton("In Progress", 1),
              _buildTabButton("Delivered", 2),
              _buildTabButton("Canceled", 3),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: tabs[activeTabIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: activeTabIndex == index ? defaultBlue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: activeTabIndex == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}





