import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'dart:async';

import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../myorders.dart';
import 'Feedback/User_Monitoring_page.dart';
import 'Feedback/View_reply.dart';
import 'User_shop.dart';

class UserHomePagewrapper extends StatelessWidget {
  const UserHomePagewrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopAuthBloc>(
      create: (context) => ShopAuthBloc()
        ..add(FetchShopesDetailsEvent(searchQuery: null, status: '0')),
      child: UserHomePage(),
    );
  }
}

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int currentIndex = 0; // Track active banner
  String selectedButton = ""; // Track selected action button
  final PageController _pageController = PageController();

  List<String> bannerImages = [
    'assets/userblog1.png',
    'assets/Buddy/maxresdefault.jpg',
    'assets/Buddy/saleoffer.jpg',
    'assets/Buddy/allensolly.jpeg',
  ];

  List<Map<String, dynamic>> serviceList = [
    {"icon": "assets/adidas.png", "name": "Adidas", "subtitle": "Ground Floor"},
    {"icon": "assets/nesto.png", "name": "Nesto", "subtitle": "Ground Floor"},
    {"icon": "assets/zara.png", "name": "Zara", "subtitle": "Ground Floor"},
    {"icon": "assets/adidas.png", "name": "Adidas", "subtitle": "Ground Floor"},
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
  }

  void _onButtonPressed(String title, BuildContext context) {
    setState(() {
      selectedButton = title;
    });

    switch (title) {
      case "Shop":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Shopwrapper()));
        break;
      case "Feedback":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserViewFeedbackwrapper()));
        break;
      case "My Order":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderHistoryScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),

              // **Header**
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
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello!", style: TextStyle(fontSize: 18)),
                      BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is loading) {
                          return Center(child: Loading_Widget());
                        } else if (state is UserByidLoaded) {
                          final user = state.Userdata;
                          return Text(' ${user.name ?? ''}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold));
                        }
                        return SizedBox();
                      })
                    ],
                  ),
                  // Spacer(),
                  // Icon(Icons.notifications, size: 30, color: Colors.black45),
                  // SizedBox(width: 10),
                  // Icon(Icons.settings, size: 30, color: Colors.black45),
                  // SizedBox(width: 10),
                ],
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

              const SizedBox(height: 28),

              // **Action Buttons**
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton("Shop", Icons.shopping_cart, context),
                    _buildActionButton("Feedback", Icons.note_alt_outlined, context),
                    _buildActionButton("My Order", Icons.info, context),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // **Recently Viewed Section**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recently Viewed",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // **Service Grid**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: BlocConsumer<ShopAuthBloc, ShopAuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ShopgetLoading) {
                      return Center(child: Loading_Widget());
                    } else if (state is Shopesfailerror) {
                      return Text(state.error.toString());
                    } else if (state is Shopesloaded) {
                      if (state.Shopes.isEmpty) {
                        // Return "No data found" if txhe list is empty
                        return Center(
                          child: Text(
                            "No data found",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: state.Shopes.length,
                        itemBuilder: (context, index) {
                          final shop = state.Shopes[index];
                          return ShopGridViewItem(
                            image: shop.Image.toString(),
                            name: shop.Shopname.toString(),
                            subtitle: shop.Selectfloor.toString(),
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // **Action Buttons with Icons & Color Change**
  Widget _buildActionButton(String title, IconData icon, BuildContext context) {
    bool isSelected = selectedButton == title;

    return GestureDetector(
      //
      onTap: () => _onButtonPressed(title, context),
      child: Container(
        height: 100,
        width: 110,
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
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // **Service Cards**
  Widget _buildServiceCard(Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(data["icon"],
                height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          SizedBox(height: 8),
          Text("suni",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(data["subtitle"],
              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
