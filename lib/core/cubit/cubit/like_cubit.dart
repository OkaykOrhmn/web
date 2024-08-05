// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/repository/product_repository.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(LikeInitial());

  void likeProduct(int id, bool like) async {
    emit(LikeLoading());
    try {
      bool response =
          await ProductRepository(dioHelper: DioHelper()).like(id, like);

      emit(LikeSuccess(response: response));
    } on DioException catch (e) {
      emit(LikeFail());
    }
  }
}
