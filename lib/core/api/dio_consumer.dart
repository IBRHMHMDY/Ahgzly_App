import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ahgzly_app/core/api/end_points.dart';
import 'package:ahgzly_app/core/errors/exceptions.dart';

// Abstract class for Dependency Injection compatibility
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
    // إعدادات Dio الأساسية
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType
          .plain // نستقبل الداتا كنص ثم نحولها json لمرونة أكبر
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! <
            500; // نعتبر الـ request ناجح إذا كان الـ status أقل من 500 لمعالجة أخطاء الـ 400 يدوياً
      };

    // إضافة Headers ثابتة
    client.options.headers = {
      'Accept': 'application/json', // ضروري جداً لـ Laravel
      'Content-Type': 'application/json',
    };

    // يمكننا هنا إضافة Interceptors لاحقاً لطباعة الـ Logs أو إضافة الـ Token
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
    // هنا سنقوم بتوسيع معالجة الأخطاء لاحقاً
    // حالياً سنرمي خطأ عام
    throw ServerException(error.message);
  }
}
