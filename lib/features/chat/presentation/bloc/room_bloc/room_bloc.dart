import 'dart:async';
import 'dart:developer';

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
        emit(state.copyWith(status: RoomStatus.loading));
        final roomEntity = await chatRepository.createRoom(
          event.roomName,
          event.username,
        );

        final currentUser = roomEntity.users[0];

        setupSubscriptions();

        emit(
          state.copyWith(
            roomEntity: roomEntity,
            users: roomEntity.users,
            roomPIN: roomEntity.pin,
            currentUser: currentUser,
            message: 'Room created successfully.',
            status: RoomStatus.roomCreateSuccess,
          ),
        );
      } catch (e) {
        log(e.toString());

        emit(state.copyWith(status: RoomStatus.error, message: e.toString()));
      }
    });

    on<JoinRoomEvent>((event, emit) async {
      emit(state.copyWith(status: RoomStatus.loading));

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
            receivedMessages: const [],
            roomEntity: roomEntity,
            users: roomEntity.users,
            currentUser: currentUser,
            roomPIN: event.pin,
            message: 'Room joined successfully.',
            status: RoomStatus.roomJoinedSuccess,
          ),
        );
      } catch (e) {
        log(e.toString());

        emit(state.copyWith(status: RoomStatus.error, message: e.toString()));
      }
    });

    on<LeaveRoomEvent>((event, emit) async {
      emit(state.copyWith(status: RoomStatus.loading));

      try {
        final leaveSuccess = await chatRepository.leaveRoom(
          event.roomId,
          event.userId,
        );

        cancelSubscriptions();

        if (leaveSuccess) {
          //this resets the state
          emit(
            RoomState(
              status: RoomStatus.roomLeftSuccess,
              message: 'Left room successfully.',
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: RoomStatus.error,
              message: 'Error occured while leaving room.',
            ),
          );
        }
      } catch (e) {
        log(e.toString());

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

        final receivedMessageEntity = ReceivedMessageEntity(
          decryptedMessage: event.sentMessage.encryptedMessage,
          userId: event.sentMessage.userId,
          username: event.sentMessage.username,
          timestamp: DateTime.parse(event.sentMessage.timestamp),
        );
        if (sentSuccess) {
          emit(
            state.copyWith(
              receivedMessages: List<ReceivedMessageEntity>.from([
                ...state.receivedMessages,
                receivedMessageEntity,
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
        log(e.toString());

        emit(
          state.copyWith(
            message: 'Cannot decrypt message. Incorrect Pin',
            status: RoomStatus.error,
          ),
        );
      }
    });

    on<OnMessageReceivedEvent>((event, emit) {
      final isMe = event.receivedMessage.userId == state.currentUser?.userId;

      if (isMe == false) {
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
          log(e.toString());

          final newMessages = List<ReceivedMessageEntity>.from([
            ...state.receivedMessages,
            event.receivedMessage,
          ]);

          emit(
            state.copyWith(
              receivedMessages: newMessages,
              message: 'Cannot decrypt message. Incorrect Pin',
              status: RoomStatus.error,
            ),
          );
        }
      }
    });

    on<OnUserJoinedEvent>((event, emit) {
      final isMe = event.joinedUser.userId == state.currentUser?.userId;

      final exists = state.users.any(
        (u) => u.userId == event.joinedUser.userId,
      );

      final newUser = UserEntity(
        username: event.joinedUser.username,
        userId: event.joinedUser.userId,
      );

      if (!exists && (isMe == false)) {
        final newUsers = List<UserEntity>.from([...state.users, newUser]);

        emit(
          state.copyWith(
            users: newUsers,
            joinedUser: event.joinedUser,
            status: RoomStatus.userJoined,
          ),
        );
      }
    });

    on<OnUserLeftEvent>((event, emit) {
      final isMe = event.leftUser.userId == state.currentUser?.userId;

      if (isMe == false) {
        final newUsers = state.users
            .where((user) => user.userId != event.leftUser.userId)
            .toList();

        emit(
          state.copyWith(
            users: newUsers,
            leftUser: event.leftUser,
            status: RoomStatus.userLeft,
          ),
        );
      }
    });

    on<OnErrorEvent>((event, emit) {
      log(event.message);
      emit(state.copyWith(message: event.message, status: RoomStatus.error));
    });
  }
}
