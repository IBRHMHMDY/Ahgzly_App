import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ahgzly_app/core/services/service_locator.dart';

void main() async {
  // التأكد من تهيئة بيئة الفلاتر قبل استدعاء أي كود Native
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة حقن التبعيات
  await ServiceLocator().init();

  runApp(const AhgzlyApp());
}

class AhgzlyApp extends StatelessWidget {
  const AhgzlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit لضبط الأحجام النسبية (مهم جداً للتصميم المتجاوب)
    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ), // حجم التصميم الافتراضي (مثلاً iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ahgzly App',
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          // سنقوم بتغيير هذا لاحقاً إلى شاشة Login أو Home حسب حالة المستخدم
          home: const Scaffold(body: Center(child: Text("Setup Complete!"))),
        );
      },
    );
  }
}
