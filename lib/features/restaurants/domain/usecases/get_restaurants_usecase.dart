import 'package:ahgzly_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:ahgzly_app/features/restaurants/domain/repositories/restaurants_repository.dart';

class GetRestaurantsUseCase {
  final RestaurantsRepository repository;

  GetRestaurantsUseCase({required this.repository});

  Future<List<RestaurantEntity>> call() {
    return repository.getRestaurants();
  }
}
