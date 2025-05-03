import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.privacy_tip, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Privacy & Policy",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "At MallBuddy, we are committed to protecting your privacy and ensuring a secure experience when using our mobile application and delivery services. This Privacy Policy outlines how we collect, use, and protect your personal data.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            _sectionTitle("1. Information We Collect"),
            _bullet("Contact Information: Name, phone number, email address."),
            _bullet("Delivery Details: Vehicle number, parking location, preferred drop-off point."),
            _bullet("Shopping Data: Store names and the types of items to be picked up."),
            _bullet("App Usage Data: Device information, app interactions, location (with permission)."),

            _sectionTitle("2. How We Use Your Information"),
            _bullet("Facilitate safe and efficient delivery of purchased items."),
            _bullet("Enable riders to locate and deliver items to the correct drop-off point."),
            _bullet("Communicate order status and delivery updates."),
            _bullet("Improve app functionality and user experience."),
            _bullet("Ensure safety and fraud prevention."),

            _sectionTitle("3. Data Sharing & Confidentiality"),
            _bullet("We do not share your personal information with third parties without your consent."),
            _bullet("Data is only shared internally with authorized MallBuddy staff and riders involved in the delivery process."),
            _bullet("All personnel handling your data are trained to maintain confidentiality and privacy."),

            _sectionTitle("4. Payment Security"),
            _bullet("All payment transactions are processed through a secure and encrypted system."),
            _bullet("We do not store any sensitive financial information such as card numbers on our servers."),

            _sectionTitle("5. Location Data"),
            _bullet("The app may request access to your location to assist in efficient pickup and delivery."),
            _bullet("You may choose to deny location permissions, though it may affect the performance of delivery services."),

            _sectionTitle("6. User Rights"),
            _bullet("Access and review the personal data we store about you."),
            _bullet("Request corrections or updates to your information."),
            _bullet("Withdraw consent for data collection (which may affect service availability)."),
            _bullet("Request deletion of your account and associated data."),

            _sectionTitle("7. Data Retention"),
            _bullet("We retain your data only as long as necessary to provide our services and comply with legal obligations."),
            _bullet("Upon account deletion, your personal data is permanently removed from our active database."),

            _sectionTitle("8. Policy Updates"),
            _bullet("This Privacy Policy may be updated periodically. Any changes will be communicated via app notifications or email."),

            _sectionTitle("9. Contact Us"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "support@mallbuddy.com",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "+91-XXXXXXXXXX",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),


            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Widget method for section titles
class _sectionTitle extends StatelessWidget {
  final String title;
  const _sectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget method for bullet points
class _bullet extends StatelessWidget {
  final String text;
  const _bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
