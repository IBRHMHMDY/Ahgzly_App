import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String token; // الـ Token أساسي للمصادقة في الطلبات اللاحقة

  const UserEntity({
    required this.name,
    required this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [name, email, token];
}
