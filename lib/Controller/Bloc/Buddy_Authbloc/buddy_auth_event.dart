import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'Buddyauthmodel/Buddyauthmodel.dart';

@immutable
sealed class BuddyAuthEvent {}

class checkBuddyloginstateevent extends BuddyAuthEvent {}

// login

class BuddyLoginEvent extends BuddyAuthEvent {
  final String Email;
  final String Password;

  BuddyLoginEvent({required this.Email, required this.Password});
}

// Signup
class BuddySignupEvent extends BuddyAuthEvent {
  final BuddyModel user;
  final String? aadhaarFilePath;
  BuddySignupEvent({required this.user, this.aadhaarFilePath});
}

//signout

class BuddySigOutEvent extends BuddyAuthEvent {}

//get all personal details

class FetchBuddyDetailsById extends BuddyAuthEvent {}

//fetch all shop

class FetchBuddyDetailsEvent extends BuddyAuthEvent {
  final String? searchQuery;
  final String? status;
  final String? floor;
  final String? amount;
  final String? Riderid;
  final String? ban;
  FetchBuddyDetailsEvent(
      {required this.searchQuery,this.status, this.floor,this.ban,this.amount,this.Riderid});
}


class AcceptRejectbuddyevent extends BuddyAuthEvent{
  final String? id;
  final String? status;
  final String? floor;
  final String? amount;
  AcceptRejectbuddyevent({required this.id, required this.status, required this.floor, required this.amount});

}
class editamountfloorevent extends BuddyAuthEvent{
  final String? id;
  final String? floor;
  final String? amount;
  editamountfloorevent({required this.floor, required this.amount, required this.id});

}

class BanBuddyrevent extends BuddyAuthEvent{
  final String? id;
  final String? Ban;
  BanBuddyrevent(
      {required this.id, required this.Ban});

}

// availabletoggle
class Buddyavailabletoggleevent extends BuddyAuthEvent{
  final String? id;
  final String? Availablestatus;
  Buddyavailabletoggleevent(
      {required this.id, required this.Availablestatus});

}
class EditBuddy extends BuddyAuthEvent {
  final BuddyModel Buddy;
  EditBuddy({required this.Buddy});
}

class EditBuddyProfile extends BuddyAuthEvent {
  final BuddyModel Buddy;
  EditBuddyProfile({required this.Buddy});
}

// class UploadFilesEvent extends BuddyAuthEvent {
//   final BuddyModel Buddy;
//   UploadFilesEvent({required this.Buddy});
// }

class UploadFilesEvent extends BuddyAuthEvent {
  final List<PlatformFile> files;

  UploadFilesEvent(this.files);

  List<Object?> get props => [files];
}

class BuddyPickAndUploadImageEvent extends BuddyAuthEvent {}
