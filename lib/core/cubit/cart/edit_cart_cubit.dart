// ignore_for_file: unused_catch_clause, unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/repository/cart_repository.dart';

part 'edit_cart_state.dart';

class EditCartCubit extends Cubit<EditCartState> {
  EditCartCubit() : super(EditCartInitial());

  void putCart({
    required final int cartId,
    required final int productId,
    required final int count,
  }) async {
    emit(EditCartLoading());
    try {
      Response response = await CartRepository(dioHelper: DioHelper())
          .putCart(cartId: cartId, productId: productId, count: count);

      emit(EditCartSuccess());
    } on DioException catch (e) {
      emit(EditCartFail());
    }
  }

  void addCart({required final int userId, required final String name}) async {
    emit(EditCartLoading());
    try {
      Response response = await CartRepository(dioHelper: DioHelper())
          .addCart(userId: userId, name: name);

      emit(EditCartSuccess());
    } on DioException catch (e) {
      emit(EditCartFail());
    }
  }
}
