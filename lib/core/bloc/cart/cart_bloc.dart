// ignore_for_file: unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/cart_list_model.dart';
import 'package:web/data/repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetAllCarts) {
        emit(CartLoading());
        try {
          final response =
              await CartRepository(dioHelper: DioHelper()).cartList();
          emit(CartSuccess(response: response));
        } on DioException catch (e) {
          emit(CartFail());
        }
      }
    });
  }
}
