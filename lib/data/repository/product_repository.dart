// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:web/data/api/api_endpoints.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/filters_model.dart';
import 'package:web/data/model/product_model.dart';

class ProductRepository extends Products {
  final DioHelper dioHelper;
  ProductRepository({required this.dioHelper});

  @override
  Future<List<Product>> productsList(
      {required final FiltersModel filtersModel}) async {
    try {
      Map<String, dynamic>? q = {};
      if (filtersModel.sort != null) {
        q.addAll({"sort": filtersModel.sort});
      }
      if (filtersModel.level != null) {
        q.addAll({"level": filtersModel.level});
      }
      if (filtersModel.take != null) {
        q.addAll({"take": filtersModel.take});
      }

      if (filtersModel.search != null) {
        q.addAll({"search": filtersModel.search});
      }

      if (filtersModel.categoryId != null) {
        q.addAll({"categoryId": filtersModel.categoryId});
      }
      final response = await dioHelper.getRequest(
          url: ApiEndPoints.product, queryParameters: q);
      List<dynamic> res = response.data['newProducts'];
      return res.map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> product(int id) async {
    try {
      final response =
          await dioHelper.getRequest(url: "${ApiEndPoints.product}/$id");
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> categories(int? take) async {
    try {
      Map<String, dynamic>? q = {};
      if (take != null) {
        q.addAll({"take": take});
      }
      final response = await dioHelper.getRequest(
          url: ApiEndPoints.categories, queryParameters: q);
      List<dynamic> res = response.data['categories'];

      return res.map((e) => Category.fromJson(e)).toList();
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> like(int id, bool like) async {
    try {
      final response = await dioHelper.putRequest(
          url: "${ApiEndPoints.product}/$id${ApiEndPoints.like}",
          data: {"like": like});

      bool res = response.data['like'];
      return res;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getLikes() async {
    try {
      final response = await dioHelper.getRequest(url: ApiEndPoints.liked);
      List<dynamic> res = response.data['liked'];

      return res.map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {
      rethrow;
    }
  }
}

abstract class Products {
  Future<List<Product>> productsList(
      {required final FiltersModel filtersModel});
  Future<ProductModel> product(int id);
  Future<List<Category>> categories(int? take);
  Future<bool> like(int id, bool like);
  Future<List<Product>> getLikes();
}
