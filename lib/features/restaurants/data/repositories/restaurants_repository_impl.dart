import 'package:ahgzly_app/core/api/dio_consumer.dart';
import 'package:ahgzly_app/core/api/end_points.dart';
import 'package:ahgzly_app/features/restaurants/data/models/restaurant_model.dart';
import 'package:ahgzly_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:ahgzly_app/features/restaurants/domain/repositories/restaurants_repository.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  final ApiConsumer apiConsumer;

  RestaurantsRepositoryImpl({required this.apiConsumer});

  @override
  Future<List<RestaurantEntity>> getRestaurants() async {
    try {
      final response = await apiConsumer.get(EndPoints.restaurants);

      // نتوقع أن البيانات تأتي داخل مفتاح "data" (Laravel Standard)
      // إذا كانت تأتي مباشرة كـ List، احذف ['data']
      final List<dynamic> data = response['data'] ?? response;

      return data.map((e) => RestaurantModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
