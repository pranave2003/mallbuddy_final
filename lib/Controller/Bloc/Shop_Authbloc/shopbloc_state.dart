// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Shopauthmodel/Shopauthmodel.dart';

@immutable
sealed class ShopAuthState {}

final class ShopAuthInitial extends ShopAuthState {}

class ShopAuthloading extends ShopAuthState {}

class ShopAuthenticated extends ShopAuthState {
  User? user;
  ShopAuthenticated(this.user);
}

class ShopUnAuthenticated extends ShopAuthState {}

class ShopAuthenticatedError extends ShopAuthState {
  final String message;

  ShopAuthenticatedError({required this.message});
}

//
final class ShopByidLoaded extends ShopAuthState {
  final ShopModel Userdata;
  ShopByidLoaded(this.Userdata);
}

class Shoploading extends ShopAuthState {}

class Shoperror extends ShopAuthState {
  String error;
  Shoperror({required this.error});
}

//Get all shopes

final class ShopgetLoading extends ShopAuthState {}

final class ShopGetSuccess extends ShopAuthState {}

final class Shopesfailerror extends ShopAuthState {
  final String error;

  Shopesfailerror(this.error);
}

class Shopesloaded extends ShopAuthState {
  final List<ShopModel> Shopes;

  Shopesloaded(
    this.Shopes,
  );
}

// Acept reject

final class ShopAcceptloading extends ShopAuthState {}

final class ShopRefresh extends ShopAuthState {}

//editshop//

final class EditshopLoading extends ShopAuthState {}

final class EditshopSuccess extends ShopAuthState {}

final class Editshopfailerror extends ShopAuthState {
  final String error;
  Editshopfailerror(this.error);
}

//banshop//

final class Shopbanloading extends ShopAuthState {}

final class ShopBanRefresh extends ShopAuthState {}

class Editshoploaded extends ShopAuthState {
  final List<ShopModel> Shop;

  Editshoploaded(
  this.Shop,
);

}




class ShopProfileImageInitial extends ShopAuthState {}

class ShopProfileImageLoading extends ShopAuthState {}

class ShopProfileImageSuccess extends ShopAuthState {
}

class ShopProfileImageFailure extends ShopAuthState {
  final String error;
  ShopProfileImageFailure(this.error);

  @override
  List<Object?> get props => [error];
}