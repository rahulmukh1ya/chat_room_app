import 'package:chat_app/common/network/connectivity_check.dart';
import 'package:chat_app/common/network/dio_http_client.dart';
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
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc());

  
}
