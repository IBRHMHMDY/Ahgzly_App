class EndPoints {
  // ملاحظة: استخدم 10.0.2.2 إذا كنت تستخدم Android Emulator للوصول للسيرفر المحلي
  // استخدم localhost أو IP جهازك إذا كنت تستخدم iOS Simulator أو جهاز حقيقي
  static const String baseUrl = "http://192.168.1.10:8000/api/";

  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String restaurants = "restaurants";
  static const String myBookings = "mybookings";
  static const String bookings = "bookings";
  static const String profile = "auth/profile";
  static const String logout = "auth/logout";
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
