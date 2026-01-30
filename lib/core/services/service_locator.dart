import 'package:ahgzly_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ahgzly_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ahgzly_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ahgzly_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ahgzly_app/features/restaurants/data/repositories/restaurants_repository_impl.dart';
import 'package:ahgzly_app/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:ahgzly_app/features/restaurants/domain/usecases/get_restaurants_usecase.dart';
import 'package:ahgzly_app/features/restaurants/presentation/bloc/restaurants_bloc.dart';
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
    //! Auth Feature
    // 1. Register Repository
    // نستخدم registerLazySingleton لأننا نريد نسخة واحدة فقط من الـ Repo
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiConsumer: sl(), cacheHelper: sl()),
    );

    // 2. Register UseCases
    // الـ UseCases خفيفة، يمكن تسجيلها كـ Factory أو Singleton
    sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
    sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));

    // 3. Blocs
    // نستخدم registerFactory لأن الـ Bloc يحتاج أن يتم تدميره وإنشاؤه مع إغلاق الشاشات (Disposal)
    sl.registerFactory(
      () => AuthBloc(loginUseCase: sl(), registerUseCase: sl()),
    );

    //! Restaurants Feature
    // Repository
    sl.registerLazySingleton<RestaurantsRepository>(
      () => RestaurantsRepositoryImpl(apiConsumer: sl()),
    );

    // UseCases
    sl.registerLazySingleton(() => GetRestaurantsUseCase(repository: sl()));

    // Bloc
    sl.registerFactory(() => RestaurantsBloc(getRestaurantsUseCase: sl()));
  }
}
