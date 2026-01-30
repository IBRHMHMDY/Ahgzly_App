import 'package:ahgzly_app/features/auth/domain/entities/user_entity.dart';
import 'package:ahgzly_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
    );
  }
}
