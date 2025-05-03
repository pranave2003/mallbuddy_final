part of 'admin_notification_bloc.dart';

@immutable
sealed class AdminNotificationEvent {}

class SendNotification_event extends AdminNotificationEvent {
  final Notificationmodel nofification;
  SendNotification_event({required this.nofification});
}
