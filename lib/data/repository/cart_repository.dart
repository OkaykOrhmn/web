// ignore_for_file: unused_catch_clause, unused_local_variable

import 'package:dio/dio.dart';
import 'package:web/data/api/api_endpoints.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/cart_list_model.dart';

class CartRepository extends Cart {
  final DioHelper dioHelper;
  CartRepository({required this.dioHelper});

  @override
  Future<CartListModel> cartList() async {
    try {
      final q = {"p": true};
      final response = await dioHelper.getRequest(
          url: ApiEndPoints.carts, queryParameters: q);

      return CartListModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartListModel> carts() async {
    try {
      final response = await dioHelper.getRequest(url: ApiEndPoints.carts);

      return CartListModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Carts> cart({required int id}) async {
    try {
      final response =
          await dioHelper.getRequest(url: "${ApiEndPoints.carts}/$id");
      return Carts.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> addCart({
    required int userId,
    required String name,
  }) async {
    try {
      final response = await dioHelper.postRequest(
          url: ApiEndPoints.carts, data: {"userId": userId, "name": name});
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> putCart({
    required final int cartId,
    required final int productId,
    required final int count,
  }) async {
    try {
      final response = await dioHelper.putRequest(
          url: "${ApiEndPoints.carts}/$cartId",
          data: {"productId": productId, "count": count});
      final res = response.data['carts'];
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteInCart(
      {required int cartId, required int productId}) async {
    try {
      final response = await dioHelper.deleteRequest(
          url:
              "${ApiEndPoints.carts}/$cartId${ApiEndPoints.product}/$productId");
      return response.data['carts'];
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> delete({required int id}) async {
    try {
      final response =
          await dioHelper.deleteRequest(url: "${ApiEndPoints.carts}/$id");
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}

abstract class Cart {
  Future<CartListModel> cartList();
  Future<Carts> cart({required final int id});
  Future<Response> delete({required final int id});
  Future<CartListModel> carts();
  Future<bool> deleteInCart(
      {required final int cartId, required final int productId});
  Future<Response> addCart({
    required int userId,
    required String name,
  });
  Future<Response> putCart({
    required final int cartId,
    required final int productId,
    required final int count,
  });
}
