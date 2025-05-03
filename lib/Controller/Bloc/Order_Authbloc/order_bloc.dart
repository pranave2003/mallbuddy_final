import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';

import 'Orderauthmodel/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});

    on<PlaceorderEvent>(
      (event, emit) async {
        emit(OrderLoading());
        try {
          var orderRef = FirebaseFirestore.instance
              .collection("Orders")
              .doc(); // Generate ID
          String orderId = orderRef.id; // Get the generated ID

          await orderRef.set({
            "useremail": event.order.useremail,
            "uid": event.order.userid,
            "invoiceid": event.order.invoiceid,
            "orderid": orderId,
            "riderid": event.order.riderid,
            "ownername": event.order.Ownername,
            "userphone": event.order.userphone,
            "Timestamp": DateTime.now(),
            "shopid": event.order.shopid,
            "selectfloor": event.order.Selectfloor,
            "vehicle_name": event.order.vehicle_name,
            "vehicle_color": event.order.vehicle_color,
            "vehicle_number": event.order.vehicle_number,
            "ridername": event.order.Ridername,
            "rideremail": event.order.rideremail,
            "contact_rider": event.order.conatctrider,
            "Review": event.order.Review,
            "Ratingstatus": event.order.Ratingstatus,
            "complaint": event.order.complaint,
            "complaintstatus": "0",
            "complainttype": event.order.complainttype,
            "sendReply": event.order.sendReply,
            "sendReplystatus": "0",
            "time": event.order.time,
            "shopname": event.order.shopname,
            "username": event.order.username,
            "status": "0",
            "payment": "0",
            "Deliverd": "0",
          });

          emit(OrderSuccess());
        } catch (e) {
          emit(Orderfailerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );
    on<BuddyActiveDeliveryAcceptevent>(
      (event, emit) async {
        try {
          emit(BuddyOrderAcceptloading());

          await FirebaseFirestore.instance
              .collection("Orders")
              .doc(event.id)
              .update({"status": event.status});
          emit(BuddyOrderRefresh());
        } catch (e) {
          print(e);
        }
      },
    );

    //UserSendComplaintevent

    on<UserSendComplaintevent>(
      (event, emit) async {
        try {
          emit(UserSendComplaintloading());

          await FirebaseFirestore.instance
              .collection("Orders")
              .doc(event.id)
              .update({
            "complaintstatus": event.complaintstatus,
            "complaint": event.complaint,
            "complainttype": event.complainttype,
          });
          emit(UserSendComplaintSuccess());
        } catch (e) {
          emit(UserSendComplaintsfailerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );
    // Sendreply
    on<UserSendreplyevent>(
      (event, emit) async {
        try {
          emit(UserSendreplyloading());

          await FirebaseFirestore.instance
              .collection("Orders")
              .doc(event.id)
              .update({
            "sendReplystatus": event.sendReplystatus,
            "sendReply": event.sendReply,
          });
          emit(UserSendComplaintSuccess());
        } catch (e) {
          emit(UserSendComplaintsfailerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );

    // UserSendreviewandratingevent
    on<UserSendreviewandratingevent>(
      (event, emit) async {
        try {
          emit(UserSendreviewandratingloading());

          await FirebaseFirestore.instance
              .collection("Orders")
              .doc(event.id)
              .update({
            "Review": event.Review,
            "Ratingstatus": event.Ratingstatus,
          });
          emit(UserSendreviewandratingSuccess());
        } catch (e) {
          emit(UserSendreviewandratingfailerror(e.toString().split("]").last));
          print("Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );

    on<OrderDelete>((event, emit) async {
      emit(OrderLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .delete();
        emit(OrderRefresh());
      } catch (e) {
        emit(Orderfailerror(e.toString()));
      }
    });

    //extend delivery Time
    on<Extenddeliverytimeevent>((event, emit) async {
      emit(OrderLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update({'time': event.updatedtime});
        emit(OrderRefresh());
      } catch (e) {
        emit(Orderfailerror(e.toString()));
      }
    });

    on<FetchPlaceorderEvent>((event, emit) async {
      emit(OrderLoading());

      try {
        CollectionReference OrderCollection =
            FirebaseFirestore.instance.collection('Orders');

        Query query = OrderCollection;
        query = query.where("status", isEqualTo: event.status);
        query =
            query.where("sendReplystatus", isEqualTo: event.sendReplystatus);
        query = query.where("shopid", isEqualTo: event.shopid);
        query = query.where("Deliverd", isEqualTo: event.Deliverd);
        query = query.where("riderid", isEqualTo: event.Riderid);
        query = query.where("uid", isEqualTo: event.userid);

        QuerySnapshot snapshot = await query.get();

        List<OrderModel> Orders = snapshot.docs.map((doc) {
          return OrderModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          Orders = Orders.where((driver) {
            return driver.Ownername!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Ordersloaded(Orders));
      } catch (e) {
        emit(Orderfailerror(e.toString()));
      }
    });

    on<Deliverd_scann_event>((event, emit) async {
      emit(scanndeliverdLoading());
      try {
        FirebaseFirestore.instance
            .collection("Orders")
            .doc(event.orderid)
            .update({"Deliverd": "1"});
        emit(Scannersuccess());
      } catch (e) {
        emit(Deliverderror(error: e.toString()));
      }
    });
  }
}
