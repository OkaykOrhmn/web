import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/login_model.dart';
import 'package:web/data/repository/auth_repositry.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthLogin) {
        emit(AuthLoading());
        try {
          final response = await AuthRepository(dioHelper: DioHelper())
              .loginUser(event.user);
          emit(AuthSuccess(response: response));
        } on DioException catch (e) {
          Response response = e.response!;
          Map<String, dynamic> data = response.data;
          emit(AuthFail(message: data['message'].toString()));
        }
      }
      if (event is AuthRegister) {
        emit(AuthLoading());
        try {
          final response = await AuthRepository(dioHelper: DioHelper())
              .registerUser(event.user);
          emit(AuthSuccess(response: response));
        } on DioException catch (e) {
          Response response = e.response!;
          Map<String, dynamic> data = response.data;
          emit(AuthFail(message: data['message'].toString()));
        }
      }
    });
  }
}
