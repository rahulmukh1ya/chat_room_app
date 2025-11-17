import 'package:chat_app/common/exceptions/custom_exception.dart';
import 'package:chat_app/common/network/connectivity_check.dart';
import 'package:chat_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:chat_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_app/features/auth/domain/entities/user_entity.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;
  final ConnectivityCheck connectivity;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
    required this.connectivity,
  });

  @override
  Future<UserEntity> loginUser(String username, String password) async {
    if (await connectivity.isConnected) {
      final authModel = await authRemoteDatasource.loginUser(
        username,
        password,
      );

      await authLocalDatasource.saveUserData(authModel.user);
      await authLocalDatasource.saveAccessToken(authModel.token);
      await authLocalDatasource.setLoggedIn(true);

      return authModel.user;
    } else {
      try {
        final userModel = await authLocalDatasource.getUserData();
        return userModel;
      } catch (e) {
        throw CustomException(e.toString());
      }
    }
  }

  @override
  Future<void> registerUser(String username, String password) async {
    if (await connectivity.isConnected) {
      return authRemoteDatasource.registerUser(username, password);
    } else {
      throw CustomException('No Internet Connected');
    }
  }
}
