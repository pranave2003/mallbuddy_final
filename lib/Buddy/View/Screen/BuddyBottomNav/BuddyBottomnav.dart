import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../Home/Profile/BuddyProfile.dart';
import '../Home/Buddy_scan.dart';
import '../Home/home.dart';

class BottomNavwrapper extends StatelessWidget {
  const BottomNavwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuddyAuthBloc()..add(FetchBuddyDetailsById()),
      child: BuddyBottomNav(),
    );
  }
}

class BuddyBottomNav extends StatefulWidget {
  @override
  _BuddyBottomNavState createState() => _BuddyBottomNavState();
}

class _BuddyBottomNavState extends State<BuddyBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    BuddyHomeScreen(),
    BuddyQRScanPage(),
    Buddyprofileavwrapper(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSvgIcon(String assetName, bool isSelected) {
    return SvgPicture.asset(
      assetName,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.blue : Colors.black,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(color: Colors.blue), // Selected label color
        unselectedLabelStyle:
            TextStyle(color: Colors.black), // Unselected label color
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
                'assets/Bottomnav/solar_home-2-bold.svg', _selectedIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
                'assets/Bottomnav/mage_scan.svg', _selectedIndex == 1),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon('assets/Bottomnav/iconamoon_profile-light.svg',
                _selectedIndex == 2),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Shop Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Scan Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
