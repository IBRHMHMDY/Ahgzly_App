import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ahgzly_app/core/services/service_locator.dart';
import 'package:ahgzly_app/core/widgets/custom_button.dart';
import 'package:ahgzly_app/core/widgets/custom_text_field.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // نستخدم BlocProvider جديد هنا أو نكتفي بالحقن
    // ملاحظة: الأفضل في Clean Architecture أن يتم توفير الـ Bloc في مستوى أعلى (مثل Route Generator)
    // لكن للتبسيط الآن سنحقنه هنا
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Account Created! Welcome ${state.user.name}",
                      ),
                    ),
                  );
                  // TODO: Navigate to Home Screen
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
                        SizedBox(height: 20.h),
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Sign up to start booking",
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                        SizedBox(height: 30.h),

                        // Name
                        CustomTextField(
                          controller: nameController,
                          hintText: "Full Name",
                          validator: (val) =>
                              val!.isEmpty ? "Name is required" : null,
                        ),
                        SizedBox(height: 16.h),

                        // Email
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val!.isEmpty ? "Email is required" : null,
                        ),
                        SizedBox(height: 16.h),

                        // Phone
                        CustomTextField(
                          controller: phoneController,
                          hintText: "Phone Number",
                          keyboardType: TextInputType.phone,
                          validator: (val) =>
                              val!.isEmpty ? "Phone is required" : null,
                        ),
                        SizedBox(height: 16.h),

                        // Password
                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password",
                          isPassword: true,
                          validator: (val) =>
                              val!.length < 6 ? "Min 6 chars" : null,
                        ),
                        SizedBox(height: 16.h),

                        // Confirm Password
                        CustomTextField(
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          isPassword: true,
                          validator: (val) {
                            if (val != passwordController.text)
                              return "Passwords do not match";
                            return null;
                          },
                        ),
                        SizedBox(height: 32.h),

                        // Register Button
                        CustomButton(
                          text: "Register",
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                RegisterEvent(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                ),
                              );
                            }
                          },
                        ),

                        // Back to Login
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Login"),
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
