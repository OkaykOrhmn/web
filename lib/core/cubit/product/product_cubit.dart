// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/data/repository/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> getProductsList(
      {final String? sort, final bool? level, final int? take}) async {
    emit(ProductLoading());
    try {
      final response = await ProductRepository(dioHelper: DioHelper())
          .productsList(sort, level, take);
      emit(ProductSuccess(response: response));
    } on DioException catch (e) {
      emit(ProductFail());
    }
  }
}
