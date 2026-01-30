import 'package:ahgzly_app/features/bookings/domain/repositories/bookings_repository.dart';

class CreateBookingUseCase {
  final BookingsRepository repository;

  CreateBookingUseCase({required this.repository});

  Future<void> call({
    required int restaurantId,
    required String date,
    required String time,
    required int guests,
  }) {
    return repository.createBooking(
      restaurantId: restaurantId,
      date: date,
      time: time,
      guests: guests,
    );
  }
}
