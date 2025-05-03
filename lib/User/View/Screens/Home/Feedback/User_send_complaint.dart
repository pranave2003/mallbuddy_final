import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';

import '../../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../../Shop/Bottomnav/Shop_Bottom.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import '../../Bottomnav/Bottom.dart';

class UserSendComplaintPage extends StatefulWidget {
  const UserSendComplaintPage({super.key, required this.id});
  final id;
  @override
  _UserSendComplaintPageState createState() => _UserSendComplaintPageState();
}

class _UserSendComplaintPageState extends State<UserSendComplaintPage> {
  String? selectedIssue;
  TextEditingController complaintController = TextEditingController();

  final List<String> complaintOptions = [
    'Late Delivery',
    'Wrong Product',
    'Damaged Package',
    'Rude Behavior',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Send Complaint',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          // Illustration Image
          Image.asset(
            'assets/Buddy/compliant.png',
            height: 150,
          ),

          SizedBox(height: 20),

          Text(
            "We're Sorry for the Trouble",
            style: TextStyle(
              fontSize: 18,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Please select a complaint reason below and share details with us",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),

          SizedBox(height: 30),

          // Complaint Dropdown
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select a complaint type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            value: selectedIssue,
            items: complaintOptions.map((issue) {
              return DropdownMenuItem(
                value: issue,
                child: Text(issue),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedIssue = value;
              });
            },
          ),

          SizedBox(height: 20),

          // Description Field
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Describe your complaint",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: complaintController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Please write here",
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),

          // const Spacer(),
SizedBox(height: 50,),
          // Submit Button
          SizedBox(
              width: double.infinity,
              height: 50,
              child: BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is UserSendComplaintSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserBottomnavwrapper(),
                        ));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {

                      // You can add logic here to send the complaint
                      if (selectedIssue == null ||
                          complaintController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Please fill in all fields")),
                        );
                      } else {
                        context.read<OrderBloc>().add(
                            UserSendComplaintevent(
                              complaintstatus: "1", id:widget.id, complaint: complaintController.text, complainttype: selectedIssue,));
                        // Send complaint logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Complaint submitted")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                      child: state is UserSendComplaintloading
                          ? Loading_Widget()
                          : const Text("Submit",
                          style:
                          TextStyle(fontSize: 18, color: Colors.white))
                  );
                },
              ))
        ],
      ),
    );
  }
}
