import 'package:chat_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginUser(String username, String password);
  Future<void> registerUser(String username, String password);
  Future<bool> checkAuthStatus();
  Future<UserEntity> getUserData();
}
