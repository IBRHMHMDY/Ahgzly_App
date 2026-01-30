import 'package:flutter/material.dart';
import 'package:ahgzly_app/features/restaurants/presentation/screens/restaurants_screen.dart';
import 'package:ahgzly_app/features/bookings/presentation/screens/my_bookings_screen.dart';
import 'package:ahgzly_app/features/auth/presentation/screens/profile_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  // قائمة الصفحات
  final List<Widget> _screens = [
    const RestaurantsScreen(),
    const MyBookingsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Restaurants",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "My Bookings",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
