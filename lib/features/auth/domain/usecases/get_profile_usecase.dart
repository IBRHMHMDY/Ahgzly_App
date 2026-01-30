import 'package:ahgzly_app/features/auth/domain/entities/user_entity.dart';
import 'package:ahgzly_app/features/auth/domain/repositories/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository repository;
  GetProfileUseCase({required this.repository});

  Future<UserEntity> call() => repository.getProfile();
}
