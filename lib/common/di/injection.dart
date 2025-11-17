import 'package:chat_app/common/network/connectivity_check.dart';
import 'package:chat_app/common/network/dio_http_client.dart';
import 'package:chat_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:chat_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/domain/usecases/login_user_usercase.dart';
import 'package:chat_app/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  //Miscellaneous
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton(() => DioHttpClient(getIt<Dio>()));

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<ConnectivityCheck>(
    () => ConnectivityCheckImpl(connectivity: Connectivity()),
  );

  //Auth Bloc
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUserUsercase: getIt<LoginUserUsercase>(),
      registerUserUsecase: getIt<RegisterUserUsecase>(),
    ),
  );

  getIt.registerLazySingleton<LoginUserUsercase>(
    () => LoginUserUsercase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUserUsecase>(
    () => RegisterUserUsecase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: getIt<AuthRemoteDatasource>(),
      authLocalDatasource: getIt<AuthLocalDatasource>(),
      connectivity: getIt<ConnectivityCheck>(),
    ),
  );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(client: getIt<DioHttpClient>()),
  );
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(prefs: getIt<SharedPreferences>()),
  );
}
