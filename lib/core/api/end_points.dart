class EndPoints {
  // Android Emulator = 10.0.2.2
  // iOS Simulator, Physical Device = (Copy IP YourDevice)  192.168.1.X
  static const String ip = "192.168.1.10";
  static const String domain = "http://$ip:8000";
  static const String storageUrl = "$domain/storage";
  static const String baseUrl = "$domain/api/";

  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String restaurants = "restaurants";
  static const String myBookings = "mybookings";
  static const String bookings = "bookings";
  static const String profile = "profile";
  static const String logout = "logout";
}

class ApiKeys {
  static const String status = "status";
  static const String message = "message";
  static const String token = "token";
  static const String email = "email";
  static const String password = "password";
  static const String confirmPassword =
      "password_confirmation"; // حسب معايير Laravel الافتراضية
}
