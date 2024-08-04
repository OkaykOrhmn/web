// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/data/repository/product_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void getCategories({final int? take}) async {
    emit(CategoriesLoading());
    try {
      final response =
          await ProductRepository(dioHelper: DioHelper()).categories(take);
      emit(CategoriesSuccess(response: response));
    } on DioException catch (e) {
      emit(CategorieFail());
    }
  }
}
