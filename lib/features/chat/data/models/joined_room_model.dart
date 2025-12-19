import 'package:chat_app/features/chat/data/models/room_model.dart';
import 'package:chat_app/features/chat/data/models/user_model.dart';
import 'package:chat_app/features/chat/domain/entities/joined_room_entity.dart';

class JoinedRoomModel extends JoinedRoomEntity {
  const JoinedRoomModel({required super.room, required super.currentUser});

  factory JoinedRoomModel.fromJson(Map<String, dynamic>? json) {
    return JoinedRoomModel(
      room: RoomModel.fromJsonForJoinedUser(json?['room'] ?? ''),
      currentUser: UserModel.fromJson(json?['user'] ?? ''),
    );
  }
}
