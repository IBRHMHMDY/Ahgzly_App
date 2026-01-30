import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ahgzly_app/core/api/end_points.dart';
import 'package:ahgzly_app/core/errors/exceptions.dart';
import 'package:ahgzly_app/core/services/cache_helper.dart';
import 'package:ahgzly_app/core/services/service_locator.dart';
import 'package:flutter/foundation.dart'; // من أجل debugPrint

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

    // إضافة Interceptors
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 1. ضمان وجود هيدر JSON دائماً
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';

          // 2. جلب التوكن وطباعته للتأكد
          final token = sl<CacheHelper>().getData(key: ApiKeys.token);
          debugPrint("🔑 TOKEN SENT: $token"); // راقب هذا السطر في الكونسول

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ RESPONSE [${response.statusCode}]: ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint(
            "❌ ERROR [${error.response?.statusCode}]: ${error.response?.data}",
          );
          return handler.next(error);
        },
      ),
    );

    // LogInterceptor للمزيد من التفاصيل
    if (kDebugMode) {
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
    }
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
    try {
      final responseJson = jsonDecode(response.data.toString());
      return responseJson;
    } on FormatException {
      // إذا فشل التحويل، فهذا يعني أن السيرفر أرسل HTML بدلاً من JSON
      throw ServerException(
        "Bad Response Format: Server returned HTML instead of JSON.\nCheck connection or Auth Token.",
      );
    }
  }

  void _handleDioError(DioException error) {
    // محاولة استخراج رسالة الخطأ من السيرفر
    String? serverMessage;
    try {
      if (error.response?.data != null) {
        final json = jsonDecode(error.response!.data.toString());
        serverMessage = json['message'] ?? json['error'];
      }
    } catch (_) {}

    throw ServerException(serverMessage ?? error.message ?? "Unknown Error");
  }
}
