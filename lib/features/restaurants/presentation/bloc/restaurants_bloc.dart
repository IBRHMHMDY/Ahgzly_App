import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahgzly_app/features/restaurants/domain/usecases/get_restaurants_usecase.dart';
import 'package:ahgzly_app/features/restaurants/presentation/bloc/restaurants_event.dart';
import 'package:ahgzly_app/features/restaurants/presentation/bloc/restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final GetRestaurantsUseCase getRestaurantsUseCase;

  RestaurantsBloc({required this.getRestaurantsUseCase})
    : super(RestaurantsInitial()) {
    on<GetRestaurantsEvent>((event, emit) async {
      emit(RestaurantsLoading());
      try {
        final restaurants = await getRestaurantsUseCase();
        emit(RestaurantsLoaded(restaurants: restaurants));
      } catch (e) {
        emit(RestaurantsError(message: e.toString()));
      }
    });
  }
}
