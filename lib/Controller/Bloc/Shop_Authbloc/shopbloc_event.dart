import 'package:flutter/cupertino.dart';

import 'Shopauthmodel/Shopauthmodel.dart';

@immutable
sealed class ShopAuthEvent {}

class checkShoploginstateevent extends ShopAuthEvent {}

// login

class ShopLoginEvent extends ShopAuthEvent {
  final String Email;
  final String Password;

  ShopLoginEvent({required this.Email, required this.Password});
}

// Signup
class ShopSignupEvent extends ShopAuthEvent {
  final ShopModel user;
  ShopSignupEvent({required this.user});
}

//signout

class ShopSigOutEvent extends ShopAuthEvent {}

//fetch details from shops
class FetchShopDetailsById extends ShopAuthEvent {}



//fetch all shop

class FetchShopesDetailsEvent extends ShopAuthEvent {
  final String? searchQuery;
  final String? status;
  FetchShopesDetailsEvent({required this.searchQuery, required this.status});
}

class ShopAcceptRejectbuddyevent extends ShopAuthEvent{
  final String? id;
  final String? status;
  ShopAcceptRejectbuddyevent({required this.id, required this.status});

}


//editshop//

class EditShop extends ShopAuthEvent {
  final ShopModel Shop;
  EditShop({required this.Shop});
}

class EditShopProfile extends ShopAuthEvent {
  final ShopModel Shop;
  EditShopProfile({required this.Shop});
}

//ban shop//
class BanShoprevent extends ShopAuthEvent{
  final String? id;
  final String? Ban;
  BanShoprevent(
      {required this.id, required this.Ban});

}

class ShopPickAndUploadImageEvent extends ShopAuthEvent {}
