import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahgzly_app/features/bookings/domain/usecases/create_booking_usecase.dart';
import 'package:ahgzly_app/features/bookings/presentation/cubit/create_booking_state.dart';

class CreateBookingCubit extends Cubit<CreateBookingState> {
  final CreateBookingUseCase createBookingUseCase;

  CreateBookingCubit({required this.createBookingUseCase})
    : super(CreateBookingInitial());

  Future<void> createBooking({
    required int restaurantId,
    required String date,
    required String time,
    required int guests,
  }) async {
    emit(CreateBookingLoading());
    try {
      await createBookingUseCase(
        restaurantId: restaurantId,
        date: date,
        time: time,
        guests: guests,
      );
      emit(CreateBookingSuccess());
    } catch (e) {
      emit(CreateBookingError(message: e.toString()));
    }
  }
}
