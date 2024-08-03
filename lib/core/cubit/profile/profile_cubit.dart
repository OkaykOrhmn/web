import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/login_model.dart';
import 'package:web/data/repository/auth_repositry.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  LoginModel? loginModel;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final response =
          await AuthRepository(dioHelper: DioHelper()).profileUser();
      loginModel = response;
      emit(ProfileSuccess());
    } on DioException catch (e) {
      if (e.response!.data['message'] == 'نشست منقضی شده است') {}
      emit(ProfileFail());
    }
  }
}
