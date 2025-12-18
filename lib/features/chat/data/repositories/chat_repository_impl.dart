import 'package:chat_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:chat_app/features/chat/data/models/sent_message_model.dart';
import 'package:chat_app/features/chat/domain/entities/joined_room_entity.dart';
import 'package:chat_app/features/chat/domain/entities/received_message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/room_entity.dart';
import 'package:chat_app/features/chat/domain/entities/sent_message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource chatRemoteDatasource;

  ChatRepositoryImpl({required this.chatRemoteDatasource});
  @override
  Future<RoomEntity> createRoom(String roomName, String username) {
    return chatRemoteDatasource.createRoom(roomName, username);
  }

  @override
  Future<void> initializePusher() {
    return chatRemoteDatasource.initializePusher();
  }

  @override
  Future<JoinedRoomEntity> joinRoom(String roomId, String username) {
    return chatRemoteDatasource.joinRoom(roomId, username);
  }

  @override
  Future<bool> sendMessage(SentMessageEntity message) {
    return chatRemoteDatasource.sendMessage(
      SentMessageModel.fromEntity(message),
    );
  }

  @override
  Future<bool> leaveRoom(String roomId, String userId) {
    return chatRemoteDatasource.leaveRoom(roomId, userId);
  }

  @override
  Stream<ReceivedMessageEntity> get messages => chatRemoteDatasource.messages;

  @override
  Stream<UserEntity> get userJoined => chatRemoteDatasource.userJoined;

  @override
  Stream<UserEntity> get userLeft => chatRemoteDatasource.userLeft;

  @override
  Future<void> disconnectPusher() {
    return chatRemoteDatasource.disconnectPusher();
  }
}
