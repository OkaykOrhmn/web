import 'package:web/data/model/product_model.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<Product> response;

  ProductsSuccess({required this.response});
}

final class ProductsFail extends ProductsState {}
