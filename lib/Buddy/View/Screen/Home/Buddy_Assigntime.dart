import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Widgets/Constants/colors.dart';

class DeliveryBoyAvailabilityPage extends StatefulWidget {
  const DeliveryBoyAvailabilityPage({super.key});

  @override
  State<DeliveryBoyAvailabilityPage> createState() =>
      _DeliveryBoyAvailabilityPageState();
}

class _DeliveryBoyAvailabilityPageState
    extends State<DeliveryBoyAvailabilityPage> {
  bool isAvailable = userData?.Availablestatus.toString()=="1 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Availability Status',
          // style: TextStyle(color: Colors.white),
        ),
        backgroundColor: defaultBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text(
                isAvailable ? "You're Available" : "You're Unavailable",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              value: isAvailable,
              onChanged: (value) {
                setState(() {
                  isAvailable = value;
                  print(value);
                  FirebaseFirestore.instance.collection('MallBuddyRiders').doc(FirebaseAuth.instance.currentUser!.uid).update({
                    'Availablestatus': isAvailable == true ? "1" : "0",
                  });
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Image.asset(
                  isAvailable
                      ? 'assets/Buddy/buddy_available.jpg' // ON image
                      : 'assets/Buddy/buddy_UNAVAILABLEIMAGE.jpeg', // OFF image
                  width: 600,
                  height: 600,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
