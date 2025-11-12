import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserUsecase {
  final AuthRepository repository;

  RegisterUserUsecase({required this.repository});

  Future<void> call({required String username, required String password}) {
    return repository.registerUser(username, password);
  }
}
