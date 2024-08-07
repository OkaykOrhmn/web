part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class GetAllCarts extends CartEvent {}

class GetCart extends CartEvent {
  final int id;

  GetCart({required this.id});
}
