import 'package:ahgzly_app/features/bookings/domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.restaurantName,
    required super.bookingDate,
    required super.bookingTime,
    required super.status,
    required super.guestCount,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      // نفترض أن الـ API يرجع اسم المطعم، أو object بداخله الاسم
      // عدل هذا السطر حسب شكل الـ JSON الفعلي
      restaurantName:
          json['restaurant_name'] ??
          json['restaurant']?['name'] ??
          'Unknown Restaurant',
      bookingDate: json['booking_date'] ?? '',
      bookingTime: json['start_at'] ?? '',
      status: json['status'] ?? 'pending',
      guestCount: int.tryParse(json['guests_count'].toString()) ?? 1,
    );
  }
}
