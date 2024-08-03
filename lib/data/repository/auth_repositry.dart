// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:web/data/api/api_endpoints.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/login_model.dart';

class AuthRepository extends Auth {
  final DioHelper dioHelper;
  AuthRepository({required this.dioHelper});

  @override
  Future<LoginModel> loginUser(User user) async {
    try {
      final response = await dioHelper.postRequest(
          url: ApiEndPoints.loginUser, data: user.toJson());
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> registerUser(User user) async {
    try {
      final response = await dioHelper.postRequest(
          url: ApiEndPoints.registerUser, data: user.toJson());
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> profileUser() async {
    try {
      final response =
          await dioHelper.getRequest(url: ApiEndPoints.profileUser);
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }
}

abstract class Auth {
  Future<LoginModel> registerUser(User user);
  Future<LoginModel> loginUser(User user);
  Future<LoginModel> profileUser();
}
