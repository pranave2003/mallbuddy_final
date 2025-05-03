import 'package:flutter/material.dart';

import '../../../../Widgets/Constants/colors.dart';
import '../Bottomnav/Bottom.dart';
import 'onboardingpage_two.dart'; // Import the next page

class OnboardingpageOne extends StatefulWidget {
  const OnboardingpageOne({super.key});

  @override
  State<OnboardingpageOne> createState() => _OnboardingpageOneState();
}

class _OnboardingpageOneState extends State<OnboardingpageOne> {
  Color skipTextColor = Colors.black; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 165),
            Image.asset('assets/boarding1.png'),
            Column(
              children: [
                const SizedBox(height: 25),
                const Text("Streamline your shopping", style: TextStyle(fontSize: 22)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("experience with", style: TextStyle(fontSize: 22)),
                    Text(" Mall Buddy.", style: TextStyle(fontSize: 22, color: defaultBlue)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 190),
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
                        MaterialPageRoute(builder: (context) => const OnboardingpageTwo()),
                      );
                    },
                    child: Container(
                      height: 56,
                      width: 142,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: defaultBlue,
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
