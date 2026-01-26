import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  late SharedPreferences sharedPreferences;

  // تهيئة المكتبة عند فتح التطبيق
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // حفظ البيانات (String, Int, Bool, Double)
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return false;
  }

  // استرجاع البيانات
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // حذف البيانات (مفيد عند تسجيل الخروج)
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  // التحقق من وجود مفتاح معين
  bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }
}
