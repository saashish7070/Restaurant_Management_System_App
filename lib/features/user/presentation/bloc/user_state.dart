part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserRegistered extends UserState {}

class UserLoggedIn extends UserState {
  final UserEntity user;
  UserLoggedIn(this.user);
}

class UserLoggedOut extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
