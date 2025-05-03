import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SectionTitle(title: '1. Service Overview'),
            SectionText(
                'MallBuddy provides a smart bag collection and delivery service within shopping malls. '
                    'Our riders collect purchased items from stores and deliver them to a designated drop-off point such as your parked vehicle or mall exit.'),

            SectionTitle(title: '2. User Responsibilities'),
            SectionText('• Users must provide accurate delivery details (e.g., vehicle number, drop-off location).'),
            SectionText('• Users must ensure their purchases are ready for pickup at the agreed time.'),
            SectionText('• Users are responsible for verifying their items upon delivery.'),

            SectionTitle(title: '3. Rider Responsibilities'),
            SectionText('• MallBuddy riders are trained to handle purchases with care and deliver them safely.'),
            SectionText('• The rider is not responsible for damaged goods if the item was already damaged before pickup.'),

            SectionTitle(title: '4. Liability Disclaimer'),
            SectionText('• MallBuddy is not liable for the condition of fragile, perishable, or mishandled goods unless proven to be damaged during delivery.'),
            SectionText('• In case of disputes or missing items, users must report within 24 hours.'),

            SectionTitle(title: '5. Payment & Charges'),
            SectionText('• Service charges apply based on the number of pickups and delivery distance.'),
            SectionText('• All payments must be made via the app’s secure payment system before or at the time of delivery.'),

            SectionTitle(title: '6. Privacy & Security'),
            SectionText('• MallBuddy values your privacy. Your personal and payment data is encrypted and securely stored.'),
            SectionText('• We do not share user data with third parties without consent.'),

            SectionTitle(title: '7. Service Availability'),
            SectionText('• The service is available only within participating malls and during mall operating hours.'),
            SectionText('• MallBuddy reserves the right to deny or cancel a service request due to safety or operational reasons.'),

            SectionTitle(title: '8. Termination of Use'),
            SectionText('• MallBuddy reserves the right to suspend or terminate accounts violating these terms, or engaging in misuse of the service.'),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  final String text;
  const SectionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.4),
      ),
    );
  }
}
