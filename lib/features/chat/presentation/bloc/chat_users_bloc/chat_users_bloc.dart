import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/domain/usecases/get_chat_users_usecase.dart';
import 'package:equatable/equatable.dart';

part 'chat_users_event.dart';
part 'chat_users_state.dart';

class ChatUsersBloc extends Bloc<ChatUsersEvent, ChatUsersState> {
  final GetChatUsersUsecase getChatUsersUsecase;

  ChatUsersBloc({required this.getChatUsersUsecase}) : super(ChatUsersState()) {
    on<GetChatUsersEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ChatUsersStatus.loading));

        final chatUsers = await getChatUsersUsecase();

        emit(
          state.copyWith(status: ChatUsersStatus.loaded, chatUsers: chatUsers),
        );
      } catch (e) {
        log(e.toString());
        emit(
          state.copyWith(message: e.toString(), status: ChatUsersStatus.error),
        );
      }
    });
  }
}
