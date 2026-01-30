import 'package:equatable/equatable.dart';
import 'package:ahgzly_app/features/bookings/domain/entities/booking_entity.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object> get props => [];
}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  final List<BookingEntity> bookings;

  const BookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

class BookingsError extends BookingsState {
  final String message;

  const BookingsError({required this.message});

  @override
  List<Object> get props => [message];
}
