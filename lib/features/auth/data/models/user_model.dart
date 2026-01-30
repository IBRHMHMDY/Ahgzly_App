import 'package:ahgzly_app/features/auth/domain/entities/user_entity.dart';
import 'package:ahgzly_app/core/api/end_points.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // التحقق من مكان وجود البيانات بناءً على هيكلية Laravel الشائعة
    // قد تكون البيانات مباشرة في الجذر أو داخل مفتاح 'data' أو 'user'
    final user = json['data'];
    

    return UserModel(
      name: user['name'].toString(), // قيمة افتراضية لتجنب null errors
      email: user['email'].toString(),
      phone: user['phone'].toString(),
      token: json[ApiKeys.token].toString(), // التوكن عادة يأتي في الجذر
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'token': token};
  }
}
