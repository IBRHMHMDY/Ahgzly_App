import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ahgzly_app/core/services/service_locator.dart';
import 'package:ahgzly_app/core/widgets/custom_button.dart';
import 'package:ahgzly_app/features/bookings/presentation/cubit/create_booking_cubit.dart';
import 'package:ahgzly_app/features/bookings/presentation/cubit/create_booking_state.dart';

class CreateBookingScreen extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;

  const CreateBookingScreen({
    super.key,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int guests = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateBookingCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Book ${widget.restaurantName}")),
        body: Padding(
          padding: EdgeInsets.all(20.w),
          child: BlocConsumer<CreateBookingCubit, CreateBookingState>(
            listener: (context, state) {
              if (state is CreateBookingSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Booking Successful!"),
                    backgroundColor: Colors.green,
                  ),
                );
                // تحديث قائمة الحجوزات (اختياري إذا أردنا تحديث القائمة فوراً)
                // sl<BookingsBloc>().add(GetMyBookingsEvent()); // يتطلب أن يكون البلوك Singleton أو Context متاح

                Navigator.pop(context); // العودة للشاشة السابقة
              } else if (state is CreateBookingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اختيار التاريخ
                  _buildLabel("Select Date"),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (picked != null) setState(() => selectedDate = picked);
                    },
                    child: _buildInputContainer(
                      selectedDate == null
                          ? "Choose Date"
                          : DateFormat('yyyy-MM-dd').format(selectedDate!),
                      Icons.calendar_today,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // اختيار الوقت
                  _buildLabel("Select Time"),
                  InkWell(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) setState(() => selectedTime = picked);
                    },
                    child: _buildInputContainer(
                      selectedTime == null
                          ? "Choose Time"
                          : selectedTime!.format(context),
                      Icons.access_time,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // عدد الضيوف
                  _buildLabel("Number of Guests"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (guests > 1) setState(() => guests--);
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        "$guests",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => guests++);
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),

                  const Spacer(),

                  CustomButton(
                    text: "Confirm Booking",
                    isLoading: state is CreateBookingLoading,
                    onPressed: () {
                      if (selectedDate == null || selectedTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select date and time"),
                          ),
                        );
                        return;
                      }

                      // تحويل الوقت لصيغة 24 ساعة (HH:mm) كما يفضلها الـ Backend عادة
                      final timeString =
                          "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}";
                      final dateString = DateFormat(
                        'yyyy-MM-dd',
                      ).format(selectedDate!);

                      context.read<CreateBookingCubit>().createBooking(
                        restaurantId: widget.restaurantId,
                        date: dateString,
                        time: timeString,
                        guests: guests,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInputContainer(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10.w),
          Text(text, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
