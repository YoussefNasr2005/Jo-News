import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:jo_news/core/networking/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static void initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger());
  }

  static Future<Response> getDio({
    required String endpoint,
    required Map<String, dynamic> query,
  }) async {
    try {
      return await dio!.get(endpoint, queryParameters: query);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<Response> postDio({
    required String endoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await dio!.post(endoint, data: data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<Response> deleteDio({
    required String endoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await dio!.delete(endoint, data: data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
