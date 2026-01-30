import 'package:ahgzly_app/core/api/dio_consumer.dart';
import 'package:ahgzly_app/core/api/end_points.dart';
import 'package:ahgzly_app/core/services/cache_helper.dart';
import 'package:ahgzly_app/features/auth/data/models/user_model.dart';
import 'package:ahgzly_app/features/auth/domain/entities/user_entity.dart';
import 'package:ahgzly_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper; // نحتاج هذا لحفظ التوكن عند النجاح

  AuthRepositoryImpl({required this.apiConsumer, required this.cacheHelper});

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.login,
        body: {ApiKeys.email: email, ApiKeys.password: password},
      );

      final user = UserModel.fromJson(response);

      // حفظ التوكن فوراً عند تسجيل الدخول الناجح
      await cacheHelper.saveData(key: ApiKeys.token, value: user.token);

      return user;
    } catch (e) {
      rethrow; // نعيد رمي الخطأ ليتعامل معه الـ Bloc
    }
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.register,
        body: {
          'name': name, // يمكن نقل هذه المفاتيح لـ ApiKeys لاحقاً
          ApiKeys.email: email,
          ApiKeys.password: password,
          ApiKeys.confirmPassword: confirmPassword,
          'phone': phone,
        },
      );

      final user = UserModel.fromJson(response);

      // حفظ التوكن عند التسجيل الناجح أيضاً
      await cacheHelper.saveData(key: ApiKeys.token, value: user.token);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> getProfile() async {
    try {
      final response = await apiConsumer.get(EndPoints.profile);
      // نفترض أن الـ JSON القادم يحتوي على User object
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      // 1. طلب تسجيل الخروج من السيرفر (لإبطال التوكن)
      await apiConsumer.post(EndPoints.logout);
    } catch (e) {
      // حتى لو فشل السيرفر (مثلاً التوكن منتهي أصلاً)، سنكمل الحذف محلياً
    } finally {
      // 2. حذف التوكن من الجهاز (أهم خطوة)
      await cacheHelper.removeData(key: ApiKeys.token);
    }
  }
}
