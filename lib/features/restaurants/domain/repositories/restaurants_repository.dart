import 'package:ahgzly_app/features/restaurants/domain/entities/restaurant_entity.dart';

abstract class RestaurantsRepository {
  Future<List<RestaurantEntity>> getRestaurants();
  // يمكن إضافة دوال أخرى لاحقاً مثل: getRestaurantDetails(id)
}
