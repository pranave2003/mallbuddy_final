import 'package:flutter/material.dart';

import '../../../../Widgets/Constants/colors.dart';
import '../Bottomnav/Bottom.dart';

class OnboardingpageThree extends StatefulWidget {
  const OnboardingpageThree({super.key});

  @override
  State<OnboardingpageThree> createState() => _OnboardingpageThreeState();
}

class _OnboardingpageThreeState extends State<OnboardingpageThree> {
  Color skipTextColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Image.asset('assets/onboarding3.png'),
            Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Your ultimate shopping  ",
                  style: TextStyle(fontSize: 22),
                ),
                Text("companion with real time updates",
                    style: TextStyle(fontSize: 22)),
                Text(
                  "Secure, Delivery & Payment.",
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            const SizedBox(
              height: 125,
            ),
            Row(
              children: [Padding(
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
                        MaterialPageRoute(builder: (context) =>  BottomNavBarExample()),
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
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
