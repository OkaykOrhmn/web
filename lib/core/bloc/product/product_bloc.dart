// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProduct) {
        emit(ProductLoading());
        try {
          final response =
              await ProductRepository(dioHelper: DioHelper()).product(event.id);
          emit(ProductSuccess(response: response));
        } on DioException catch (e) {
          emit(ProductFail());
        }
      }
    });
  }
}
