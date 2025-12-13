import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/usecases/connect_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/dispose_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/get_user_conversation_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ConnectChatUsecase connectChatUsecase;
  final DisposeChatUsecase disposeChatUsecase;
  final GetMessagesUsecase getMessagesUsecase;
  final SendMessageUsecase sendMessageUsecase;
  final GetUserConversationUsecase getUserConversationUsecase;
  StreamSubscription<MessageEntity>? _messageSubscription;

  ChatBloc({
    required this.connectChatUsecase,
    required this.disposeChatUsecase,
    required this.getMessagesUsecase,
    required this.sendMessageUsecase,
    required this.getUserConversationUsecase,
  }) : super(ChatState()) {
    on<ChatConnectEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ChatStatus.loading));

        await connectChatUsecase();

        _messageSubscription = getMessagesUsecase().listen(
          (message) => add(MessageReceivedEvent(message: message)),
          onError: (error) =>
              emit(state.copyWith(error: error, status: ChatStatus.error)),
        );
      } catch (e) {
        emit(state.copyWith(error: e.toString(), status: ChatStatus.error));
      }
    });

    on<MessageReceivedEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: ChatStatus.loaded,
          messages: [...state.messages, event.message],
        ),
      );
    });

    on<GetUserConversationEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ChatStatus.loading));

        final messages = await getUserConversationUsecase(event.userId);

        emit(state.copyWith(status: ChatStatus.loaded, messages: messages));
      } catch (e) {
        emit(state.copyWith(error: e.toString(), status: ChatStatus.error));
      }
    });

    on<MessageSentEvent>((event, emit) async {
      try {
        await sendMessageUsecase(event.recipientId, event.text);
      } catch (e) {
        emit(state.copyWith(status: ChatStatus.error, error: e.toString()));
      }
    });

    on<ChatDisposeEvent>((event, emit) async {
      _messageSubscription?.cancel();
      disposeChatUsecase();
      emit(ChatState());
    });
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    disposeChatUsecase();
    return super.close();
  }
}
