part of 'product_cubit.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<Product> response;

  ProductSuccess({required this.response});
}

final class ProductFail extends ProductState {}
