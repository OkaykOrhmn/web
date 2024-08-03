import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:web/data/api/api_endpoints.dart';
import 'package:web/data/storage/token.dart';

class DioHelper {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseURL,
    connectTimeout: const Duration(milliseconds: 30000),
    contentType: ContentType.json.toString(),
    responseType: ResponseType.json,
  ))
    ..interceptors.add(PrettyDioLogger());

  Dio get sendRequest => _dio;

  Future<Response> getRequest(
      {required final String url,
      final Map<String, dynamic>? queryParameters}) async {
    return await sendRequest.get(url,
        options: await getDioOptions(), queryParameters: queryParameters);
  }

  Future<Response> putRequest(
      {required final String url, final Object? data}) async {
    return await sendRequest.put(url,
        data: data, options: await getDioOptions());
  }

  Future<Response> deleteRequest({
    required final String url,
    final Object? data,
  }) async {
    return await sendRequest.delete(url,
        data: data, options: await getDioOptions());
  }

  Future<Response> postRequest(
      {required final String url,
      final Object? data,
      final Map<String, dynamic>? queryParameters}) async {
    return await sendRequest.post(url,
        data: data,
        queryParameters: queryParameters,
        options: await getDioOptions());
  }
}

Future<Options> getDioOptions() async {
  final token = await getToken();
  return Options(headers: {
    "Content-Type": "application/json",
    'accept': '*/*',
    'Authorization': "Bearer $token",
  });
}
