part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final ProductModel response;

  ProductSuccess({required this.response});
}

final class ProductFail extends ProductState {}
