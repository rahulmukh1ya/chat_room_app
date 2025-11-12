import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUserUsercase {
  final AuthRepository repository;

  LoginUserUsercase({required this.repository});

  Future<UserEntity> call({
    required String username,
    required String password,
  }) {
    return repository.loginUser(username, password);
  }
}
