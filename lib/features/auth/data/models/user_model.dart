import 'package:ahgzly_app/features/auth/domain/entities/user_entity.dart';
import 'package:ahgzly_app/core/api/end_points.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // التحقق من مكان وجود البيانات بناءً على هيكلية Laravel الشائعة
    // قد تكون البيانات مباشرة في الجذر أو داخل مفتاح 'data' أو 'user'
    final userData = json['user'] ?? json['data'] ?? json;

    return UserModel(
      name: userData['name'] ?? '', // قيمة افتراضية لتجنب null errors
      email: userData['email'] ?? '',
      token: json[ApiKeys.token] ?? '', // التوكن عادة يأتي في الجذر
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'token': token};
  }
}
