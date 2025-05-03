import 'package:flutter/material.dart';


import '../../../../Widgets/Constants/colors.dart';
import '../Bottomnav/Bottom.dart';
import 'onboardingpage_three.dart';

class OnboardingpageTwo extends StatefulWidget {
  const OnboardingpageTwo({super.key});

  @override
  State<OnboardingpageTwo> createState() => _OnboardingpageTwoState();
}

class _OnboardingpageTwoState extends State<OnboardingpageTwo> {
  Color skipTextColor = Colors.black; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Image.asset('assets/boarding2.png'),
            Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Shop in store, request ",
                  style: TextStyle(fontSize: 22),
                ),
                Text("delivery & relax as we deliver",
                    style: TextStyle(fontSize: 22)),
                Text(
                  "your purchase to your car.",
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ), const SizedBox(
              height: 125,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        skipTextColor = defaultBlue; // Change color to blue
                      });

                      Future.delayed(const Duration(milliseconds: 200), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavBarExample()), // Navigate to home page
                        );
                      });
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(fontSize: 22, color: skipTextColor, ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OnboardingpageThree()),
                      );
                    },
                  child: Container(
                    height: 56,
                    width: 142,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: defaultBlue),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Next",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
