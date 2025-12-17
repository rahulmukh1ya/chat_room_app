import 'package:chat_app/features/chat/domain/entities/joined_room_entity.dart';
import 'package:chat_app/features/chat/domain/entities/received_message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/room_entity.dart';
import 'package:chat_app/features/chat/domain/entities/sent_message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';

abstract class ChatRepository {
  Future<void> initializePusher();

  Future<RoomEntity> createRoom(String roomName, String username);
  Future<JoinedRoomEntity> joinRoom(String roomId, String username);
  Future<bool> leaveRoom(String roomId, String userId);

  Future<bool> sendMessage(SentMessageEntity message);

  Stream<ReceivedMessageEntity> get messages;
  Stream<UserEntity> get userJoined;
  Stream<UserEntity> get userLeft;
}
