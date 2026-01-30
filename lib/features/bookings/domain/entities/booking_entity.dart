import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final int id;
  final String restaurantName;
  final String bookingDate; // String للتبسيط، يمكن تحويلها لـ DateTime
  final String bookingTime;
  final String status; // pending, confirmed, cancelled
  final int guestCount;

  const BookingEntity({
    required this.id,
    required this.restaurantName,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    required this.guestCount,
  });

  @override
  List<Object?> get props => [
    id,
    restaurantName,
    bookingDate,
    bookingTime,
    status,
    guestCount,
  ];
}
