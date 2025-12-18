import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/common/services/encryption_service.dart';
import 'package:chat_app/features/chat/domain/entities/received_message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/room_entity.dart';
import 'package:chat_app/features/chat/domain/entities/sent_message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final ChatRepository chatRepository;

  StreamSubscription<ReceivedMessageEntity>? _receivedMessageSubscription;
  StreamSubscription<UserEntity>? _joinedUserSubscription;
  StreamSubscription<UserEntity>? _leftUserSubscription;

  RoomBloc({required this.chatRepository}) : super(RoomState()) {
    void setupSubscriptions() {
      _receivedMessageSubscription?.cancel();
      _joinedUserSubscription?.cancel();
      _leftUserSubscription?.cancel();

      _receivedMessageSubscription = chatRepository.messages.listen(
        (message) => add(OnMessageReceivedEvent(receivedMessage: message)),
        onError: (error) => add(OnErrorEvent(message: error.toString())),
      );

      _joinedUserSubscription = chatRepository.userJoined.listen(
        (user) => add(OnUserJoinedEvent(joinedUser: user)),
        onError: (error) => add(OnErrorEvent(message: error.toString())),
      );

      _leftUserSubscription = chatRepository.userLeft.listen(
        (user) => add(OnUserLeftEvent(leftUser: user)),
        onError: (error) => add(OnErrorEvent(message: error.toString())),
      );
    }

    void cancelSubscriptions() {
      _receivedMessageSubscription?.cancel();
      _joinedUserSubscription?.cancel();
      _leftUserSubscription?.cancel();
    }

    on<CreateRoomEvent>((event, emit) async {
      try {
        final roomEntity = await chatRepository.createRoom(
          event.roomName,
          event.username,
        );

        final currentUser = roomEntity.users[0];

        setupSubscriptions();

        emit(
          state.copyWith(
            roomEntity: roomEntity,
            roomPIN: roomEntity.pin,
            currentUser: currentUser,
            status: RoomStatus.roomCreateSuccess,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: RoomStatus.error, message: e.toString()));
      }
    });

    on<JoinRoomEvent>((event, emit) async {
      try {
        final joinedRoomEntity = await chatRepository.joinRoom(
          event.roomId,
          event.userName,
        );

        final roomEntity = joinedRoomEntity.room;

        final currentUser = joinedRoomEntity.currentUser;

        setupSubscriptions();

        emit(
          state.copyWith(
            roomEntity: roomEntity,
            currentUser: currentUser,
            roomPIN: event.pin,
            status: RoomStatus.roomJoinedSuccess,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: RoomStatus.error, message: e.toString()));
      }
    });

    on<LeaveRoomEvent>((event, emit) async {
      try {
        final leaveSuccess = await chatRepository.leaveRoom(
          event.roomId,
          event.userId,
        );

        cancelSubscriptions();

        if (leaveSuccess) {
          emit(state.copyWith(status: RoomStatus.roomLeftSuccess));
        } else {
          emit(
            state.copyWith(
              status: RoomStatus.error,
              message: 'Error occured while leaving room.',
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: RoomStatus.error, message: e.toString()));
      }
    });

    on<MessageSendEvent>((event, emit) async {
      try {
        final encryptedMessage = EncryptionService.encryptMessage(
          event.sentMessage.encryptedMessage,
          state.roomPIN ?? '',
        );

        final sentMessageEntity = event.sentMessage.copyWith(
          encryptedMessage: encryptedMessage,
        );

        final sentSuccess = await chatRepository.sendMessage(sentMessageEntity);

        if (sentSuccess) {
          emit(
            state.copyWith(
              receivedMessages: List<ReceivedMessageEntity>.from([
                ...state.receivedMessages,
                event.sentMessage,
              ]),
              status: RoomStatus.loaded,
            ),
          );
        } else {
          emit(
            state.copyWith(
              message: 'Failed to encrypt message',
              status: RoomStatus.error,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            message: 'Cannot decrypt message. Incorrect Pin',
            status: RoomStatus.error,
          ),
        );
      }
    });

    on<OnMessageReceivedEvent>((event, emit) {
      final isNotMe = event.receivedMessage.userId != state.currentUser?.userId;

      if (isNotMe) {
        try {
          final decryptedMessage = EncryptionService.decryptMessage(
            event.receivedMessage.decryptedMessage,
            state.roomPIN ?? '',
          );

          final newMessages = List<ReceivedMessageEntity>.from([
            ...state.receivedMessages,
            event.receivedMessage.copyWith(decryptedMessage: decryptedMessage),
          ]);

          emit(
            state.copyWith(
              receivedMessages: newMessages,
              status: RoomStatus.loaded,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              message: 'Cannot decrypt message. Incorrect Pin',
              status: RoomStatus.error,
            ),
          );
        }
      }
    });

    on<OnUserJoinedEvent>((event, emit) {
      final isNotMe = event.joinedUser.userId != state.currentUser?.userId;

      if (isNotMe) {
        emit(
          state.copyWith(
            joinedUser: event.joinedUser,
            status: RoomStatus.userJoined,
          ),
        );
      }
    });

    on<OnUserLeftEvent>((event, emit) {
      final isNotMe = event.leftUser.userId != state.currentUser?.userId;

      if (isNotMe) {
        emit(
          state.copyWith(leftUser: event.leftUser, status: RoomStatus.userLeft),
        );
      }
    });

    on<OnErrorEvent>((event, emit) {
      emit(state.copyWith(message: event.message, status: RoomStatus.error));
    });
  }
}
