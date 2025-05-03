import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendNotification(String token, String title, String body) async {
  var serverKey = 'YOUR_FIREBASE_SERVER_KEY'; // replace with your server key

  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    },
    body: jsonEncode({
      'to': token,
      'notification': {
        'title': title,
        'body': body,
      },
    }),
  );
}
