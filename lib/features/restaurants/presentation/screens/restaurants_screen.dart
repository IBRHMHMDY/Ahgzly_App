import 'package:ahgzly_app/core/services/service_locator.dart';
import 'package:ahgzly_app/features/restaurants/presentation/bloc/restaurants_bloc.dart';
import 'package:ahgzly_app/features/restaurants/presentation/bloc/restaurants_event.dart';
import 'package:ahgzly_app/features/restaurants/presentation/bloc/restaurants_state.dart';
import 'package:ahgzly_app/features/restaurants/presentation/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RestaurantsBloc>()..add(GetRestaurantsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Restaurants"),
          centerTitle: false,
          automaticallyImplyLeading:
              false, // لإخفاء زر الرجوع لأننا في HomeLayout
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
            builder: (context, state) {
              if (state is RestaurantsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RestaurantsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 50.sp, color: Colors.red),
                      SizedBox(height: 10.h),
                      Text(state.message),
                      TextButton(
                        onPressed: () {
                          context.read<RestaurantsBloc>().add(
                            GetRestaurantsEvent(),
                          );
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else if (state is RestaurantsLoaded) {
                if (state.restaurants.isEmpty) {
                  return const Center(child: Text("No restaurants found"));
                }
                return ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: state.restaurants.length,
                  itemBuilder: (context, index) {
                    return RestaurantCard(
                      restaurant: state.restaurants[index],
                      onTap: () {
                        // TODO: Navigate to Details Screen
                      },
                    );
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