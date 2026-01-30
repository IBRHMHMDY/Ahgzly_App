import 'package:equatable/equatable.dart';
import 'package:ahgzly_app/features/restaurants/domain/entities/restaurant_entity.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
  @override
  List<Object> get props => [];
}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  final List<RestaurantEntity> restaurants;
  const RestaurantsLoaded({required this.restaurants});
  @override
  List<Object> get props => [restaurants];
}

class RestaurantsError extends RestaurantsState {
  final String message;
  const RestaurantsError({required this.message});
  @override
  List<Object> get props => [message];
}
