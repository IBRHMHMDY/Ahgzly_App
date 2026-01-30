import 'package:ahgzly_app/core/api/dio_consumer.dart';
import 'package:ahgzly_app/core/api/end_points.dart';
import 'package:ahgzly_app/features/bookings/data/models/booking_model.dart';
import 'package:ahgzly_app/features/bookings/domain/entities/booking_entity.dart';
import 'package:ahgzly_app/features/bookings/domain/repositories/bookings_repository.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  final ApiConsumer apiConsumer;
  BookingsRepositoryImpl({required this.apiConsumer});

  @override
  Future<List<BookingEntity>> getMyBookings() async {
    try {
      final response = await apiConsumer.get(EndPoints.myBookings);
      final List<dynamic> data = response['data'] ?? response;
      return data.map((e) => BookingModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createBooking({
    required int restaurantId,
    required String date,
    required String time,
    required int guests,
  }) async {
    try {
      await apiConsumer.post(
        EndPoints.bookings,
        body: {
          'restaurant_id': restaurantId,
          'booking_date': date,
          'start_at': time,
          'guests_count': guests,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

}
