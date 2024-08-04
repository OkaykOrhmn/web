// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/products/Products_state.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/repository/product_repository.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  Future<void> getProductsList(
      {final String? sort, final bool? level, final int? take}) async {
    emit(ProductsLoading());
    try {
      final response = await ProductRepository(dioHelper: DioHelper())
          .productsList(sort, level, take);
      emit(ProductsSuccess(response: response));
    } on DioException catch (e) {
      emit(ProductsFail());
    }
  }
}
