import 'package:ahgzly_app/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ahgzly_app/core/services/service_locator.dart';
import 'package:ahgzly_app/core/widgets/custom_button.dart';
import 'package:ahgzly_app/core/widgets/custom_text_field.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // حقن الـ Bloc هنا لأنه مطلوب لهذه الشاشة فقط حالياً
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Welcome ${state.user.name}")),
                  );
                  // TODO: Navigate to Home Screen later
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Login to access your bookings",
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                        SizedBox(height: 40.h),
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password",
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(
                          text: "Login",
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // إطلاق الحدث للـ Bloc
                              context.read<AuthBloc>().add(
                                LoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text("Register"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
