import 'package:ahgzly_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:ahgzly_app/features/bookings/domain/repositories/bookings_repository.dart';

class GetMyBookingsUseCase {
  final BookingsRepository repository;
  GetMyBookingsUseCase({required this.repository});

  Future<List<BookingEntity>> call() => repository.getMyBookings();
}
