import 'package:dio/dio.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/helper/shared_pref_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiManager {
  late Dio _dio;

  ApiManager() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Logger
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));

    // Token Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SharedPrefHelper.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get({required String endpoint}) async {
    return await _dio.get(endpoint);
  }

  Future<Response> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    return await _dio.post(endpoint, data: data);
  }

  Future<Response> put({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    return await _dio.put(endpoint, data: data);
  }

  Future<Response> delete({required String endpoint}) async {
    return await _dio.delete(endpoint);
  }
}