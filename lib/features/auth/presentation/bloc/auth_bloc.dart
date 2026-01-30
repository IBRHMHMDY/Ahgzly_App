import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahgzly_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ahgzly_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitial()) {
    // معالجة حدث تسجيل الدخول
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final result = await loginUseCase(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess(user: result));
      } catch (e) {
        // هنا يمكن تحسين معالجة الأخطاء لاستخراج الرسالة بشكل أدق
        emit(AuthError(message: e.toString()));
      }
    });

    // معالجة حدث إنشاء حساب
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final result = await registerUseCase(
          name: event.name,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
          phone: event.phone,
        );
        emit(AuthSuccess(user: result));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
