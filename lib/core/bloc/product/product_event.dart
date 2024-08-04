part of 'product_bloc.dart';

sealed class ProductEvent {}

class GetProduct extends ProductEvent {
  final int id;

  GetProduct({required this.id});
}
