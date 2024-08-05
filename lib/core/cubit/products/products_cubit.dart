// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/core/cubit/products/Products_state.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/filters_model.dart';
import 'package:web/data/repository/product_repository.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  Future<void> getProductsList(
      {required final FiltersModel filtersModel}) async {
    emit(ProductsLoading());
    try {
      final response = await ProductRepository(dioHelper: DioHelper())
          .productsList(filtersModel: filtersModel);
      emit(ProductsSuccess(response: response));
    } on DioException catch (e) {
      emit(ProductsFail());
    }
  }
}
