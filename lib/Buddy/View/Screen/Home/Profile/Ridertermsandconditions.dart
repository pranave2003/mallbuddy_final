import 'package:flutter/material.dart';



class RiderTermsScreen extends StatelessWidget {
  final Map<String, List<String>> _termsSections = {
    "Rider Eligibility": [
      "Must be 18 years or older with valid ID.",
      "Must have a smartphone and be familiar with using mobile apps.",
      "Must pass background verification as required by MallBuddy.",
    ],
    "Rider Responsibilities": [
      "Collect items from stores listed by the user with proper verification.",
      "Safely transport items to the user’s selected drop-off location (e.g., vehicle, mall exit).",
      "Handle all packages with care and respect store instructions.",
      "Communicate clearly with the user in case of delays or confusion.",
      "Use the app for real-time updates and delivery confirmations.",
    ],
    "Prohibited Conduct": [
      "Mishandling or theft of any items.",
      "Misuse of customer information or app data.",
      "Providing false delivery updates or accepting unauthorized tasks.",
      "Engaging in rude, aggressive, or inappropriate behavior with customers or store staff.",
    ],
    "Delivery Liability": [
      "Riders are responsible for the safe handling of packages after pickup.",
      "Riders are not liable for items already damaged at the store, but must report such issues before accepting pickup.",
      "Any deliberate damage or negligence may result in penalties or termination.",
    ],
    "Earnings & Payments": [
      "Payments are processed weekly or as per app policy.",
      "Riders are paid per successful delivery, based on distance and package volume.",
      "Bonuses or tips (if any) are credited transparently through the app.",
    ],
    "App & Equipment Usage": [
      "Riders must keep their phones charged and location enabled during working hours.",
      "Riders are responsible for any loss of their own personal items or equipment.",
      "Riders must update the app regularly and follow platform guidelines.",
    ],
    "Termination & Suspension": [
      "MallBuddy reserves the right to suspend or terminate any rider account for:",
      "Violating rules",
      "Customer complaints",
      "Repeated delivery issues or misconduct",
    ],
    "Legal Compliance": [
      "Riders must follow local laws regarding traffic, delivery practices, and ID requirements.",
      "MallBuddy is not responsible for any legal violations committed by the rider.",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rider Terms & Conditions")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _termsSections.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...entry.value.map((point) => Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• ", style: TextStyle(fontSize: 18)),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
