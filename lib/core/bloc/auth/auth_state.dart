part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final LoginModel response;

  AuthSuccess({required this.response});
}

final class AuthFail extends AuthState {
  final String message;

  AuthFail({required this.message});
}
