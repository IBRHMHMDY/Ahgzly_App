import 'package:ahgzly_app/core/services/service_locator.dart';
import 'package:ahgzly_app/features/bookings/presentation/bloc/bookings_bloc.dart';
import 'package:ahgzly_app/features/bookings/presentation/bloc/bookings_event.dart';
import 'package:ahgzly_app/features/bookings/presentation/bloc/bookings_state.dart';
import 'package:ahgzly_app/features/bookings/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BookingsBloc>()..add(GetMyBookingsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Bookings"),
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<BookingsBloc, BookingsState>(
            builder: (context, state) {
              if (state is BookingsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookingsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 50.sp, color: Colors.red),
                      SizedBox(height: 10.h),
                      Text(state.message),
                      TextButton(
                        onPressed: () => context.read<BookingsBloc>().add(
                          GetMyBookingsEvent(),
                        ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else if (state is BookingsLoaded) {
                if (state.bookings.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 60.sp,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 16.h),
                        const Text("No bookings yet"),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: state.bookings.length,
                  itemBuilder: (context, index) {
                    return BookingCard(booking: state.bookings[index]);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}