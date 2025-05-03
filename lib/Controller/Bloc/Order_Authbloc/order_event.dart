part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class PlaceorderEvent extends OrderEvent {
  final OrderModel order;
  PlaceorderEvent({required this.order});
}

class FetchPlaceorderEvent extends OrderEvent {
  final String? searchQuery;
  final String? status;
  final String? sendReplystatus;
  final String? shopid;
  final String? Deliverd;
  final String? Riderid;
  final String? userid;
  final String? floor;
  FetchPlaceorderEvent(
      {required this.searchQuery,
      this.status,
        this.sendReplystatus,
      this.shopid,
      this.Deliverd,
      this.Riderid,
      this.userid,
      this.floor});
}

class OrderDelete extends OrderEvent {
  final String? orderid;
  OrderDelete({required this.orderid});
}
//Extend delivery time
class Extenddeliverytimeevent extends OrderEvent {
  final String? orderid;
  final String? updatedtime;
  Extenddeliverytimeevent({required this.orderid,this.updatedtime});
}

class Deliverd_scann_event extends OrderEvent {
  final String? orderid;
  Deliverd_scann_event({required this.orderid});
}

//BuddyActiveDeliveryAccept//
class BuddyActiveDeliveryAcceptevent extends OrderEvent {
  final String? id;
  final String? status;
  BuddyActiveDeliveryAcceptevent({required this.id, required this.status});
}

//UserSendComplaint//
class UserSendComplaintevent extends OrderEvent {
  final String? id;
  final String? complaintstatus;
  final String? complaint;
  final String? complainttype;
  UserSendComplaintevent(
      {required this.id,
      this.complaintstatus,
      this.complaint,
      this.complainttype});
}
// Sendreply
class UserSendreplyevent extends OrderEvent {
  final String? id;
  final String? sendReplystatus;
  final String? sendReply;
  UserSendreplyevent(
      {required this.id,
      this.sendReplystatus,
      this.sendReply,
      });
}


// UserSendreviewandratingevent
class UserSendreviewandratingevent extends OrderEvent {
  final String? id;
  final String? Review;
  final String? Ratingstatus;
  UserSendreviewandratingevent(
      {required this.id,
      this.Review,
      this.Ratingstatus,});
}
