import 'package:chat_app/common/network/connectivity_check.dart';
import 'package:chat_app/common/network/dio_http_client.dart';
import 'package:chat_app/common/services/pusher_service.dart';
import 'package:chat_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:chat_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/features/chat/presentation/bloc/pusher_bloc/pusher_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/room_bloc/room_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  //Miscellaneous
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  final pusher = PusherChannelsFlutter.getInstance();

  getIt.registerLazySingleton<PusherService>(
    () => PusherService(pusher: pusher),
  );

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton(() => DioHttpClient(getIt<Dio>()));

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<ConnectivityCheck>(
    () => ConnectivityCheckImpl(connectivity: Connectivity()),
  );

  getIt.registerLazySingleton<PusherBloc>(
    () => PusherBloc(chatRepository: getIt<ChatRepository>()),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () =>
        ChatRepositoryImpl(chatRemoteDatasource: getIt<ChatRemoteDatasource>()),
  );

  getIt.registerLazySingleton<ChatRemoteDatasource>(
    () => ChatRemoteDatasourceImpl(
      pusherService: getIt<PusherService>(),
      client: getIt<DioHttpClient>(),
    ),
  );

  getIt.registerLazySingleton<RoomBloc>(
    () => RoomBloc(chatRepository: getIt<ChatRepository>()),
  );
}
