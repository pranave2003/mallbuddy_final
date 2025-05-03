import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../Service/Notification_onesignal/Keys.dart';
import 'NotificationModel/NotificationModel.dart';
import 'admin_notification_state.dart';

part 'admin_notification_event.dart';

class AdminNotificationBloc
    extends Bloc<AdminNotificationEvent, AdminNotificationState> {
  String Url = 'https://api.onesignal.com/notifications?c=push';
  AdminNotificationBloc() : super(AdminNotificationInitial()) {
    on<SendNotification_event>((event, emit) async {
      emit(NotificationSend_Loading());
      try {
        var response = await http.post(Uri.parse(Url),
            headers: {
              "Authorization": "Key ${Apikeys.Apikey}",
              "content-type": "application/json",
              "accept": "application/json"
            },
            body: jsonEncode({
              "app_id": Apikeys.Appid,
              "contents": {
                "en": event.nofification.NotificationContent,
              },
              "included_segments": ['Total Subscriptions'],
              "headings": {"en": event.nofification.NotificationMatter},
              "subtitle": {"en": "Sub title"},
              "data": {"screen": "/category"},
              "small_icon": "Assets/img.png",
            }));
        if (response.statusCode == 200) {
          // Generate a new document reference with a unique ID
          final docRef =
              FirebaseFirestore.instance.collection("Notification").doc();

// Get the generated document ID
          String docId = docRef.id;

// Store the data along with the ID
          await docRef.set({
            "id": docId,
            "title": event.nofification.NotificationMatter,
            "Content": event.nofification.NotificationContent,
            "Date": event.nofification.NotificationDate,
            "Time": event.nofification.NotificationTime,
          });
          emit(NotificationSend_Success());
          print("Notification send successfully ${response.body}");
          emit(NotificationSend_message(
              message: "Notification send successfully "));
        } else {
          print(
              "Notification failed  with status code ${response.statusCode} and message is ${response.body}");
          emit(NotificationSend_Error(
              error:
                  "Notification failed  with status code ${response.statusCode} and message is ${response.body}"));
        }
      } on Exception catch (e) {
        emit(NotificationSend_Error(error: e.toString()));
        print("Error Occured : $e");
      }
    });
  }
}
