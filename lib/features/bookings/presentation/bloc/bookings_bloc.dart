import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahgzly_app/features/bookings/domain/usecases/get_my_bookings_usecase.dart';
import 'package:ahgzly_app/features/bookings/presentation/bloc/bookings_event.dart';
import 'package:ahgzly_app/features/bookings/presentation/bloc/bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final GetMyBookingsUseCase getMyBookingsUseCase;

  BookingsBloc({required this.getMyBookingsUseCase})
    : super(BookingsInitial()) {
    on<GetMyBookingsEvent>((event, emit) async {
      emit(BookingsLoading());
      try {
        final bookings = await getMyBookingsUseCase();
        emit(BookingsLoaded(bookings: bookings));
      } catch (e) {
        emit(BookingsError(message: e.toString()));
      }
    });
  }
}
