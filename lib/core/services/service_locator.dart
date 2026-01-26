import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahgzly_app/core/api/dio_consumer.dart';
import 'package:ahgzly_app/core/services/cache_helper.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    //! External
    // تسجيل SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    // تسجيل Dio
    sl.registerLazySingleton(() => Dio());

    //! Core
    // تسجيل CacheHelper
    // ملاحظة: قمنا بتسجيل SharedPreferences مسبقاً، لذا يمكننا حقنها هنا يدوياً أو تعديل CacheHelper لاستقبالها
    // للتبسيط في هذا المشروع، سنستخدم النسخة المسجلة في sl داخل CacheHelper إذا عدلناه،
    // أو نستخدم الطريقة الأبسط بتسجيل CacheHelper كـ Singleton وتجريده.

    // الطريقة الأفضل: CacheHelper يعتمد على SharedPreferences
    sl.registerLazySingleton<CacheHelper>(() {
      final cacheHelper = CacheHelper();
      cacheHelper.sharedPreferences =
          sl<SharedPreferences>(); // حقن الـ dependency يدوياً
      return cacheHelper;
    });

    // تسجيل ApiConsumer (DioConsumer)
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

    //! Features
    // سنقوم بتسجيل الـ Blocs و Repositories الخاصة بالـ Auth هنا في الخطوات القادمة
  }
}
