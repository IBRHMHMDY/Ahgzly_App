import 'package:ahgzly_app/features/bookings/domain/entities/booking_entity.dart';

abstract class BookingsRepository {
  Future<List<BookingEntity>> getMyBookings();
}
