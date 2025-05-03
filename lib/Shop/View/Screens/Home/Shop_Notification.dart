import 'package:flutter/material.dart';



class ShopNotificationScreen extends StatelessWidget {
  const ShopNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {},
        // ),
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [ const SizedBox(height: 300,),
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile/girl.png"), // Replace with your profile image
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            _buildDateHeader("Today, Jan 22"),
            _buildNotificationItem(
              icon: Icons.shopping_bag,
              title: "Your Order is Ready for Pickup!",
              subtitle: "Your order is ready for pickup",
              timeAgo: "5 sec ago",
            ),
            _buildNotificationItem(
              icon: Icons.local_offer,
              title: "75% Off at Allen Solly Store!",
              subtitle: "Exclusive sale until this weekend on clothing",
              timeAgo: "5 sec ago",
            ),
            _buildNotificationItem(
              icon: Icons.local_offer,
              title: "75% Off at Allen Solly Store!",
              subtitle: "Exclusive sale until this weekend on clothing",
              timeAgo: "5 sec ago",
            ),
            _buildDateHeader("Yesterday, Jan 21"),
            _buildNotificationItem(
              icon: Icons.local_offer,
              title: "75% Off at Allen Solly Store!",
              subtitle: "Exclusive sale until this weekend on clothing",
              timeAgo: "5 sec ago",
            ),
            _buildNotificationItem(
              icon: Icons.local_offer,
              title: "75% Off at Allen Solly Store!",
              subtitle: "Exclusive sale until this weekend on clothing",
              timeAgo: "5 sec ago",
            ),
          ],
        ),
      ),
    );
  }

  // Date Header
  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        date,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Notification Item
  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String timeAgo,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                timeAgo,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
