import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Home/User_Home_page.dart';

class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _currentIndex = 0; // Track the selected page

  final List<Widget> _pages = [
    UserHomePage(),
    PageTwo(),
    PageTwo(),
    PageTwo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bottom Navigation Example")),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle:
            TextStyle(color: Colors.red), // Selected label color to red
        unselectedLabelStyle:
            TextStyle(color: Colors.blue), // Unselected label color to yellow
        selectedIconTheme: IconThemeData(color: Colors.blue),
        selectedItemColor: Colors.blue, // Color of selected icon & text
        unselectedItemColor: Colors.black,
        backgroundColor: Color(0xffF3F3F3),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, // Add this line
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected page
          });
        },
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: "Shop"),
          // BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is Page 1', style: TextStyle(fontSize: 24)),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is Page 2', style: TextStyle(fontSize: 24)),
    );
  }
}
