part of 'cart_bloc.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartListModel response;

  CartSuccess({required this.response});
}

final class CartFail extends CartState {}
