import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUsecase {
  final AuthRepository repository;

  CheckAuthStatusUsecase({required this.repository});

  Future<bool> call() {
    return repository.checkAuthStatus();
  }
}
