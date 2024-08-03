// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:web/data/api/api_endpoints.dart';
import 'package:web/data/api/dio_helper.dart';
import 'package:web/data/model/product_model.dart';

class ProductRepository extends Products {
  final DioHelper dioHelper;
  ProductRepository({required this.dioHelper});

  @override
  Future<List<Product>> productsList(String? sort, bool? level) async {
    try {
      Map<String, dynamic>? q = {};
      if (sort != null) {
        q = {"sort": sort};
        if (level != null) {
          q = {"sort": sort, "level": level};
        }
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
          await dioHelper.postRequest(url: "${ApiEndPoints.product}/$id");
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> categories() async {
    try {
      final response = await dioHelper.getRequest(url: ApiEndPoints.categories);
      List<dynamic> res = response.data['categories'];

      return res.map((e) => Category.fromJson(e)).toList();
    } on DioException catch (e) {
      rethrow;
    }
  }
}

abstract class Products {
  Future<List<Product>> productsList(String? sort, bool? level);
  Future<ProductModel> product(int id);
  Future<List<Category>> categories();
}
