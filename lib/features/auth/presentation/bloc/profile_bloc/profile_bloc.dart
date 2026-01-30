import 'package:ahgzly_app/features/auth/presentation/bloc/profile_bloc/profile_event.dart';
import 'package:ahgzly_app/features/auth/presentation/bloc/profile_bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahgzly_app/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:ahgzly_app/features/auth/domain/usecases/logout_usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileBloc({required this.getProfileUseCase, required this.logoutUseCase})
    : super(ProfileInitial()) {
    // جلب البيانات
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await getProfileUseCase();
        emit(ProfileLoaded(user: user));
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });

    // تسجيل الخروج
    on<LogoutEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        await logoutUseCase();
        emit(LogoutSuccess());
      } catch (e) {
        // حتى لو حدث خطأ، سنعتبره خرج (لأننا حذفنا التوكن محلياً في الـ Repo)
        emit(LogoutSuccess());
      }
    });
  }
}
