import 'package:chat_app/common/network/connectivity_check.dart';
import 'package:chat_app/common/network/dio_http_client.dart';
import 'package:chat_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/features/chat/domain/usecases/connect_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/dispose_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/get_chat_users_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/get_user_conversation_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_users_bloc/chat_users_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
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

  

  getIt.registerFactory<ChatBloc>(
    () => ChatBloc(
      connectChatUsecase: getIt<ConnectChatUsecase>(),
      disposeChatUsecase: getIt<DisposeChatUsecase>(),
      getMessagesUsecase: getIt<GetMessagesUsecase>(),
      sendMessageUsecase: getIt<SendMessageUsecase>(),
      getUserConversationUsecase: getIt<GetUserConversationUsecase>(),
    ),
  );

  getIt.registerFactory<ChatUsersBloc>(
    () => ChatUsersBloc(
      getChatUsersUsecase: getIt<GetChatUsersUsecase>()
    ),
  );

  getIt.registerLazySingleton<ConnectChatUsecase>(
    () => ConnectChatUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<DisposeChatUsecase>(
    () => DisposeChatUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<GetMessagesUsecase>(
    () => GetMessagesUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<SendMessageUsecase>(
    () => SendMessageUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<GetChatUsersUsecase>(
    () => GetChatUsersUsecase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<GetUserConversationUsecase>(
    () => GetUserConversationUsecase(repository: getIt<ChatRepository>()),
  );

  getIt.registerLazySingleton<ChatRepository>(
    () =>
        ChatRepositoryImpl(chatRemoteDatasource: getIt<ChatRemoteDatasource>()),
  );

  getIt.registerLazySingleton<ChatRemoteDatasource>(
    () => ChatRemoteDatasourceImpl(
      authLocalDataSource: getIt<AuthLocalDatasource>(),
      client: getIt<DioHttpClient>(),
    ),
  );
}
