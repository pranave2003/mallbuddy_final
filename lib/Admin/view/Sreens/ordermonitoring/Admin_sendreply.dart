import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import 'View_Complaint.dart';

class AdminSendReplyPage extends StatefulWidget {

  final String complaintId;
  final String userName;
  final String complaintSubject;
  final String complaintText;

  AdminSendReplyPage({
    required this.complaintId,
    required this.userName,
    required this.complaintSubject,
    required this.complaintText,
  });

  @override
  State<AdminSendReplyPage> createState() => _AdminSendReplyPageState();
}

class _AdminSendReplyPageState extends State<AdminSendReplyPage> {
  TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Reply", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetail("Order_ID", widget.complaintId),
            _buildDetail("User_Name", widget.userName),
            _buildDetail("Subject", widget.complaintSubject),
            _buildDetail("Complaint", widget.complaintText),

            SizedBox(height: 20),

            Text(
              "Type your reply",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: replyController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Write your reply here...",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
    child: BlocConsumer<OrderBloc, OrderState>(
    listener: (context, state) {
    if (state is UserSendreplySuccess) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => AdminViewComplaintswrapper(),
    ));
    }
    },
    builder: (context, state) {
    return  ElevatedButton(
                onPressed: () {
                  // Add logic to send reply (API/Firebase etc.)
                  if (replyController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a reply")),
                    );
                  } else {
                    context.read<OrderBloc>().add(
                        UserSendreplyevent(
                          sendReplystatus: "1", id:widget.complaintId, sendReply: replyController.text, ));
                    // Send logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Reply sent successfully")),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                  child: state is UserSendreplyloading
                      ? Loading_Widget()
                      : const Text("Submit",
                      style:
                      TextStyle(fontSize: 18, color: Colors.white))

    );
    }
    ),


            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
          SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              value,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
