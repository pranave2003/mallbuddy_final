import 'package:flutter/material.dart';

import '../auth/User_login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 2000),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return User_LoginPage();
      },));
      //Navigator.push(context, MaterialPageRoute(builder: (context) => ''));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset('assets/ogLogo.png'),
                Positioned(
                  bottom: 90, left: 120,
                    child: Text("Enhance your shopping\n   Experience with us!",style: TextStyle(fontSize: 16),)),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
