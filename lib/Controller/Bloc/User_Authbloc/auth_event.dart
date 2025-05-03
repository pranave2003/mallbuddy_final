part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// check auth or not
class checkloginstateevent extends AuthEvent {}

// login

class LoginEvent extends AuthEvent {
  final String Email;
  final String Password;

  LoginEvent({required this.Email, required this.Password});
}

// Signup
class SignupEvent extends AuthEvent {
  final UserModel user;
  SignupEvent({required this.user});
}

//signout
class SigOutEvent extends AuthEvent {}

//fetch details from users
class FetchUserDetailsById extends AuthEvent {}

// fetc all users

class FetchUsers extends AuthEvent {
  final String? searchQuery;
  FetchUsers(
      {required this.searchQuery});
}

class BanUserevent extends AuthEvent{
  final String? id;
  final String? Ban;
  BanUserevent(
      {required this.id, required this.Ban});

}

class PickAndUploadImageEvent extends AuthEvent {}
