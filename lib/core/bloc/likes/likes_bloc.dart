// ignore_for_file: unused_catch_clause

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/product_model.dart';
import 'package:web/data/repository/product_repository.dart';

part 'likes_event.dart';
part 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  LikesBloc() : super(LikesInitial()) {
    on<LikesEvent>((event, emit) async {
      if (event is GetAllLikes) {
        emit(LikesLoading());
        try {
          final response =
              await ProductRepository(dioHelper: DioHelper()).getLikes();
          emit(LikesSuccess(response: response));
        } on DioException catch (e) {
          emit(LikesFail());
        }
      }
    });
  }
}
