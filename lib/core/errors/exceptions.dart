class ServerException implements Exception {
  final String? message;
  // يمكن إضافة ErrorModel هنا لاحقاً لمعالجة أخطاء الـ Validation القادمة من Laravel
  const ServerException([this.message]);

  @override
  String toString() => message ?? "Unknown Server Error";
}

class CacheException implements Exception {}
