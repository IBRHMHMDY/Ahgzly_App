import 'package:ahgzly_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // دالة تسجيل الدخول
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> getProfile();
  Future<void> logout();
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword, // Laravel يتطلب تأكيد كلمة المرور
    required String phone, // مفيد لتطبيقات الحجز
  });
}
