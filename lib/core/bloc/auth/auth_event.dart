part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthLogin extends AuthEvent {
  final User user;

  AuthLogin({required this.user});
}

class AuthRegister extends AuthEvent {
  final User user;

  AuthRegister({required this.user});
}
