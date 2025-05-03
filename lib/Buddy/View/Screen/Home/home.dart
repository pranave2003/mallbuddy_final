import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Shop/View/Screens/Home/Shop_Notification.dart';

import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import 'activedelivery/Activedelivery.dart';
import 'Buddy_Assigntime.dart';
import 'Buddy_completedeliveryfirstpage.dart';

class BuddyHomeScreen extends StatefulWidget {
  @override
  _BuddyHomeScreenState createState() => _BuddyHomeScreenState();
}

class _BuddyHomeScreenState extends State<BuddyHomeScreen> {
  String? selectedButton; // T// rack selec
  int currentIndex = 0; // Track active banner
  final PageController _pageController = PageController();
  List<String> bannerImages = [
    'assets/userblog1.png',
    'assets/Buddy/saleoffer.jpg',
    'assets/Buddy/maxresdefault.jpg',
    'assets/Buddy/allensolly.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (currentIndex + 1) % bannerImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  } // ted action button

  void _onButtonPressed(String title, BuildContext context) {
    setState(() {
      selectedButton = title;
    });

    switch (title) {
      case "Availability\nStatus":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DeliveryBoyAvailabilityPage())); // Use the correct page
        break;
      case "Active\nDelivery":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BUddy_Active_delivery()));
        break;
      case "Completed\nDelivery":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BuddyCompleteDeliveryFirstScreenwrapper()));
        break;
    }
  }


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
                                BlocBuilder<BuddyAuthBloc, BuddyAuthState>(
                  builder: (context, state) {
                    if (state is Buddyloading) {
                      return const Center(child: Loading_Widget());
                    } else if (state is BuddyByidLoaded) {
                      final user = state.Userdata;
                      return Text('${user.name ?? ''}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold));
                    }
                    return SizedBox();
                  },
                                )
                              ],
                            ),
                            Spacer(),
                            SizedBox(width: 10),

                            Row(
                              children: [
                                SizedBox(width: 10,),
                                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShopNotificationScreen()), // Navigate to ProfilePage
                    );
                  },
                                child: Icon(Icons.notifications_on_sharp, size: 30, color: Colors.black45)),
                              ],
                            ),
                            SizedBox(width: 10),
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
                          ],
                        ),
                        SizedBox(height: 20),

                        // Today Delivery Section
                        Row(
                          children: [
                            Text(
                              "Today Delivery",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Delivery Status Card
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: defaultBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Image.asset("assets/ShopBottomnav/pending.png"),
                              ),
                              deliveryStatusItem("Pending\nDelivery", "4", Icons.access_time),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Image.asset("assets/ShopBottomnav/done.png"),
                              ),
                              deliveryStatusItem("Done\nDelivery", "10", Icons.check_circle),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // **Image Slider**
                        SizedBox(
                          height: 180,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemCount: bannerImages.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                bannerImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // **Indicator (Blue Dots)**
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(bannerImages.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                height: 10,
                                width: currentIndex == index ? 30 : 10,
                                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: currentIndex == index
                      ? Colors.blueAccent
                      : Colors.black.withOpacity(0.4),
                                ),
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: 16),
                        // Quick Actions Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildActionButton("Availability\nStatus", Icons.more_time, context),

                            _buildActionButton("Completed\nDelivery", Icons.done_all, context),

                            _buildActionButton("Active\nDelivery", Icons.info, context),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Earnings",
                              style: TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),
                        // Earnings Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                  height: 200,
                  width: 160,
                  decoration: BoxDecoration(
                      color: defaultBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                              "assets/ShopBottomnav/todayearning.png")),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Total Earnings",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 40,
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
                              ],
                            ),
                            Container(
                              height: 200,
                              width: 160,
                              decoration: BoxDecoration(
                  color: defaultBlue, borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          Image.asset("assets/ShopBottomnav/totalearning.png")),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Total Earnings",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 40,
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
                          ],
                        ),
                      ]),
                ))));
  }

  Widget _buildActionButton(String title, IconData icon, BuildContext context) {
    bool isSelected = selectedButton == title;

    return GestureDetector(
      onTap: () => _onButtonPressed(title, context),
      child: Container(
        height: 88,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.blueAccent : Colors.blue[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black),
            SizedBox(height: 5),
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget deliveryStatusItem(String title, String count, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
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
}
