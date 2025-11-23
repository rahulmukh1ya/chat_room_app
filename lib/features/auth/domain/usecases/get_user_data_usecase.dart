import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';

class GetUserDataUsecase {
  final AuthRepository repository;

  GetUserDataUsecase({required this.repository});

  Future<UserEntity> call() {
    return repository.getUserData();
  }
}