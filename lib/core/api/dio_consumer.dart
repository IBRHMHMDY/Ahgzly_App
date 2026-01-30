import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ahgzly_app/core/api/end_points.dart';
import 'package:ahgzly_app/core/errors/exceptions.dart';
import 'package:ahgzly_app/core/services/cache_helper.dart'; // import CacheHelper
import 'package:ahgzly_app/core/services/service_locator.dart'; // import sl

abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool isFormData = false,
  });
}

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..connectTimeout = const Duration(seconds: 20)
      ..receiveTimeout = const Duration(seconds: 20)
      ..validateStatus = (status) {
        return status! < 500;
      };

    client.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

    // ✅ إضافة Auth Interceptor
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // قراءة التوكن مباشرة من الـ CacheHelper باستخدام sl
          // ملاحظة: يمكن حقن CacheHelper في الـ Constructor ليكون أنظف (Dependency Injection)
          // لكن للتبسيط ولأن sl متاح عالمياً، سنستخدمه هنا
          final token = sl<CacheHelper>().getData(key: ApiKeys.token);

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? body,
    bool isFormData = false,
  }) async {
    try {
      final response = await client.post(
        path,
        data: isFormData ? FormData.fromMap(body!) : body,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  void _handleDioError(DioException error) {
    throw ServerException(error.message);
  }
}
