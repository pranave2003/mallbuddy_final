import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../monitoring/Admin_monitor.dart';
import 'Order/Shop_Userselectparking.dart';
import '../shop_active_delivery.dart';
import '../shop_complete_delivery.dart';
import 'Shop_Notification.dart';
import 'Shop_ProfilePage.dart';

class ShopHomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.add_shopping_cart_outlined, "label": "Delivery\nBooking"},
    {
      "icon": Icons.shopping_cart_checkout_outlined,
      "label": "Active\nDelivery"
    },
    {"icon": Icons.done_all, "label": "Complete\nDelivery"},
    {"icon": Icons.list_alt, "label": "Rider\nMonitoring"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(children: [
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueAccent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset('assets/logo.png'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hello!", style: TextStyle(fontSize: 18)),
                                BlocBuilder<ShopAuthBloc, ShopAuthState>(
                    builder: (context, state) {
                  if (state is Shoploading) {
                    return Center(child: Loading_Widget());
                  } else if (state is ShopByidLoaded) {
                    final user = state.Userdata;
                    return Text(' ${user.Ownername ?? ''}',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
                  }
                  return SizedBox();
                                })
                              ],
                            ),
                            // Spacer(),
                            // SizedBox(width: 10),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               ShopNotificationScreen()), // Navigate to ProfilePage
                            //     );
                            //   },
                            // child: Icon(Icons.notifications_on_sharp, size: 30, color: Colors.black45),),
                            // SizedBox(width: 10),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               Shopprofileavwrapper()), // Navigate to ProfilePage
                            //     );
                            //   },
                            //   child: CircleAvatar(
                            //     radius: 20, // Adjust size as needed
                            //     backgroundImage: AssetImage("assets/profile/girl.png"),
                            //     backgroundColor: Colors
                            //         .transparent, // Optional: Make the background transparent
                            //   ),
                            // ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 50),

                        // Today Delivery Section
                        Row(
                          children: [
                            SizedBox(height: 40),
                            Text(
                              "Today Delivery",
                              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Delivery Status Card
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: defaultBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Image.asset("assets/ShopBottomnav/pending.png"),
                              ),
                              deliveryStatusItem("Pending\nDelivery", "4", Icons.access_time),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Image.asset("assets/ShopBottomnav/done.png"),
                              ),
                              deliveryStatusItem("Done\nDelivery", "10", Icons.check_circle),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Text(
                              "Categories",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        // Quick Actions Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: categories.map((category) {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to the respective page
                                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => getCategoryPage(category["label"]),
                  ),
                                );
                              },
                              child: Column(
                                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 30,
                    child: Icon(category["icon"], size: 30, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(category["label"], style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 20),

                        /// Category Icons Row
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: categories.map((category) {
                        //     return Column(
                        //       children: [
                        //         CircleAvatar(
                        //           backgroundColor: Colors.grey[200],
                        //           radius: 30,
                        //           child: Icon(category["icon"], size: 30, color: Colors.black),
                        //         ),
                        //         SizedBox(height: 5),
                        //         Text(category["label"], style: TextStyle(fontSize: 14)),
                        //       ],
                        //     );
                        //   }).toList(),
                        // ),
                        SizedBox(
                          height: 40,
                          width: 20,
                        ),
                        Row(
                          children: [
                            // SizedBox(width: 20,),
                            Text(
                              "Earnings",
                              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),

                        // Earnings Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                                color: defaultBlue, borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10)),
                                                    child:
                                                        Image.asset("assets/ShopBottomnav/totalearning.png")),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Total Earnings",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(120),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "45000",
                                                      style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                  ],
                                ),
                                // child: earningsCard("Today Earnings", "₹1000")
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                                color: defaultBlue, borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10)),
                                                    child:
                                                        Image.asset("assets/ShopBottomnav/totalearning.png")),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Total Earnings",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(120),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "500000",
                                                      style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                )
                                  ],
                                ),
                                // child: earningsCard("Today Earnings", "₹1000")
                              ),
                            ),
                          ],
                        ),
                      ]),
                ))));
  }

  // Widget for Delivery Status
  Widget deliveryStatusItem(String title, String count, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Widget for Quick Actions
  Widget quickActionItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.black),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Widget for Earnings Card
  Widget earningsCard(String title, String amount) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryPage(String label) {
    switch (label) {
      case "Delivery\nBooking":
        return UserListselectparkingwrapper();
      case "Active\nDelivery":
        return ActiveDeliverywrapper();
      case "Complete\nDelivery":
        return CompleteDeliverywrapper();
      case "Rider\nMonitoring":
        return ShopViewComplaintsPage();
      default:
        return ShopHomeScreen(); // Default to home if no match found
    }
  }
}
