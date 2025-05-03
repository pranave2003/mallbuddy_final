import 'package:flutter/material.dart';

class RiderPrivacyPolicyPage extends StatelessWidget {
  const RiderPrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rider Privacy Policy"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.privacy_tip, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "MallBuddy – Rider Privacy Policy",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "By joining the MallBuddy Rider Program, you agree to the collection, use, and protection of your data as described below. This policy explains how your information is handled while using the MallBuddy Rider App and services.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            _sectionTitle("1. Information We Collect"),
            _bullet("Personal Details: Name, contact number, email address, and government-issued ID."),
            _bullet("Device Data: Device type, OS version, app usage data."),
            _bullet("Location Data: Real-time location during delivery shifts (with permission)."),
            _bullet("Vehicle Information: Vehicle number, type, and model."),
            _bullet("Activity Logs: Delivery activity, communication logs, and route history."),

            _sectionTitle("2. How We Use Your Information"),
            _bullet("To manage and verify rider profiles and background checks."),
            _bullet("To assign and track delivery tasks in real time."),
            _bullet("To provide earnings reports and payment processing."),
            _bullet("For customer service communication and dispute resolution."),
            _bullet("To improve service quality and ensure compliance with policies."),

            _sectionTitle("3. Location Services"),
            _bullet("Your location is used to match you with delivery tasks nearby."),
            _bullet("Location tracking is active only during delivery hours."),
            _bullet("You can disable location access, but it will affect task assignment."),

            _sectionTitle("4. Data Sharing"),
            _bullet("We do not sell or share your personal information with third parties for marketing."),
            _bullet("Data may be shared internally with authorized MallBuddy staff for operational purposes."),
            _bullet("In cases of legal obligations or law enforcement requests, data may be disclosed."),

            _sectionTitle("5. Data Security"),
            _bullet("All rider data is securely stored using encryption and access controls."),
            _bullet("Regular system updates are in place to prevent unauthorized access or breaches."),

            _sectionTitle("6. Payment Data"),
            _bullet("Payment information is processed securely via third-party payment gateways."),
            _bullet("We do not store sensitive financial details like debit/credit card numbers."),

            _sectionTitle("7. Your Rights"),
            _bullet("Access your personal data upon request."),
            _bullet("Request corrections to your profile."),
            _bullet("Withdraw consent for data usage (this may limit service access)."),
            _bullet("Request deletion of your rider account and associated data."),

            _sectionTitle("8. Policy Updates"),
            _bullet("MallBuddy may update this Privacy Policy periodically."),
            _bullet("You will be notified via the app or email whenever significant changes are made."),

            _sectionTitle("9. Contact Information"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              children: [
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