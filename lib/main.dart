import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ahgzly_app/core/api/end_points.dart';
import 'package:ahgzly_app/core/services/cache_helper.dart';
import 'package:ahgzly_app/core/services/service_locator.dart';
import 'package:ahgzly_app/features/auth/presentation/screens/login_screen.dart';
import 'package:ahgzly_app/features/home/presentation/screens/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. تهيئة الخدمات
  await ServiceLocator().init();

  // 2. التحقق من التوكن
  // بما أننا سجلنا CacheHelper كـ Singleton، يمكننا استخدامه عبر sl
  final token = sl<CacheHelper>().getData(key: ApiKeys.token);

  // 3. تحديد شاشة البداية
  Widget startWidget;
  if (token != null && token != "") {
    startWidget = const HomeLayout();
  } else {
    startWidget = const LoginScreen();
  }

  runApp(AhgzlyApp(startWidget: startWidget));
}

class AhgzlyApp extends StatelessWidget {
  final Widget startWidget;

  const AhgzlyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ahgzly App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            // تنسيق موحد للـ Input Decoration إذا أردت
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // نمرر الشاشة التي حددناها
          home: startWidget,
        );
      },
    );
  }
}
