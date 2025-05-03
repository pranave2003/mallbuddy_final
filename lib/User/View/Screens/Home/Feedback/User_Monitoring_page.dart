import 'package:flutter/material.dart';

import 'User_send_complaint.dart';
import 'feedback.dart';

class UserMonitoring_Page extends StatefulWidget {
  const UserMonitoring_Page({super.key, required this.id});

  final id;
  @override
  State<UserMonitoring_Page> createState() => _UserMonitoring_PageState();
}

class _UserMonitoring_PageState extends State<UserMonitoring_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // First complaint: Late Delivery
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserSendComplaintPage(id: widget.id),
                    ));
                // Handle Late Delivery tap
              },
              child: Container(
                width: 380,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Send Complaint",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10), // Space between the two options
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackPage(id: widget.id,),
                    ));
                // Handle Late Delivery tap
              },
              child: Container(
                width: 380,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Send Review & Rating",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            // Second complaint: Wrong Product
            // GestureDetector(
            //   onTap: () {
            //     // Handle Wrong Product tap
            //   },
            //   child: Container(
            //     width: 380,
            //     height: 60,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(8),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.3),
            //           spreadRadius: 2,
            //           blurRadius: 5,
            //           offset: Offset(0, 3),
            //         ),
            //       ],
            //     ),
            //     padding: EdgeInsets.symmetric(horizontal: 16),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Rider Performance",
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         Icon(
            //           Icons.arrow_forward_ios,
            //           size: 16,
            //           color: Colors.grey,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
