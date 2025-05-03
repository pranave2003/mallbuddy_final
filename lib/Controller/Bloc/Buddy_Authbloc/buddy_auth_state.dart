import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Buddyauthmodel/Buddyauthmodel.dart';

@immutable
sealed class BuddyAuthState {}

final class BuddyAuthInitial extends BuddyAuthState {}

class BuddyAuthloading extends BuddyAuthState {}

class BuddyAuthenticated extends BuddyAuthState {
  User? user;
  BuddyAuthenticated(this.user);
}

class BuddyUnAuthenticated extends BuddyAuthState {}

class BuddyAuthenticatedError extends BuddyAuthState {
  final String message;

  BuddyAuthenticatedError({required this.message});
}

// get all personal details

final class BuddyByidLoaded extends BuddyAuthState {
  final BuddyModel Userdata;
  BuddyByidLoaded(this.Userdata);
}

class Buddyloading extends BuddyAuthState {}

class Buddyerror extends BuddyAuthState {
  String error;
  Buddyerror({required this.error});
}

//Get all Buddy

final class BuddygetLoading extends BuddyAuthState {}

final class BuddyGetSuccess extends BuddyAuthState {}

final class Buddyfailerror extends BuddyAuthState {
  final String error;

  Buddyfailerror(this.error);
}

class Buddyloaded extends BuddyAuthState {
  final List<BuddyModel> Buddys;

  Buddyloaded(
    this.Buddys,
  );
}

// Acept reject

final class Acceptloading extends BuddyAuthState {}

final class Refresh extends BuddyAuthState {}

//ban

final class Buddybanloading extends BuddyAuthState {}

final class BuddyBanRefresh extends BuddyAuthState {}

class BuddyProfileImageInitial extends BuddyAuthState {}

class BuddyProfileImageLoading extends BuddyAuthState {}

class BuddyProfileImageSuccess extends BuddyAuthState {}

class BuddyProfileImageFailure extends BuddyAuthState {
  final String error;
  BuddyProfileImageFailure(this.error);

  @override
  List<Object?> get props => [error];
}

final class BuddyRefresh extends BuddyAuthState {}

final class EditBuddyLoading extends BuddyAuthState {}

final class EditBuddySuccess extends BuddyAuthState {}

final class EditBuddyfailerror extends BuddyAuthState {
  final String error;
  EditBuddyfailerror(this.error);
}

//Buddyavailabletoggle

final class BuddyavailabletoggleSuccess extends BuddyAuthState {}

final class Buddyavailabletogglefailerror extends BuddyAuthState {
  final String error;

  Buddyavailabletogglefailerror(this.error);
}


final class Buddyavailabletoggleloading extends BuddyAuthState {}

final class BuddyavailabletoggleRefresh extends BuddyAuthState {}

//Get all ImageFileUpload

class BuddyImageFileUploadLoading extends BuddyAuthState {}

class BuddyImageFileUploadSuccess extends BuddyAuthState {
  final List<String> downloadUrls;

  BuddyImageFileUploadSuccess(this.downloadUrls);

  List<Object?> get props => [downloadUrls];
}

class BuddyImageFileUploadfailerror extends BuddyAuthState {
  final String error;

  BuddyImageFileUploadfailerror(this.error);

  List<Object?> get props => [error];
}

class BuddyImageFileUploadloaded extends BuddyAuthState {
  final List<BuddyModel> Buddys;

  BuddyImageFileUploadloaded(
      this.Buddys,
      );
}
