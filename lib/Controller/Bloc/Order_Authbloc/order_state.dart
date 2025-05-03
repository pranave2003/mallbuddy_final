part of 'order_bloc.dart';

@immutable
//order
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderSuccess extends OrderState {}

final class OrderRefresh extends OrderState {}

final class BuddyOrderAcceptloading extends OrderState {}

final class BuddyOrderRefresh extends OrderState {}

final class Orderfailerror extends OrderState {
  final String error;

  Orderfailerror(this.error);
}

class Ordersloaded extends OrderState {
  final List<OrderModel> Orders;

  Ordersloaded(
      this.Orders,
      );
}

//UserSendComplaintSuccess

final class UserSendComplaintSuccess extends OrderState {}

final class UserSendComplaintsfailerror extends OrderState {
  final String error;

  UserSendComplaintsfailerror(this.error);
}


final class UserSendComplaintloading extends OrderState {}

final class UserSendComplaintRefresh extends OrderState {}

//UserSendreplySuccess

final class UserSendreplySuccess extends OrderState {}

final class UserSendreplyfailerror extends OrderState {
  final String error;

  UserSendreplyfailerror(this.error);
}


final class UserSendreplyloading extends OrderState {}

final class UserSendreplyRefresh extends OrderState {}


//UserSendreviewandratingSuccess

final class UserSendreviewandratingSuccess extends OrderState {}

final class UserSendreviewandratingfailerror extends OrderState {
  final String error;

  UserSendreviewandratingfailerror(this.error);
}


final class UserSendreviewandratingloading extends OrderState {}

final class UserSendreviewandratingRefresh extends OrderState {}


//Scanner

class scanndeliverdLoading extends OrderState {}

class Scannersuccess extends OrderState {}

class Deliverderror extends OrderState {
  final String error;
  Deliverderror({required this.error});
}
