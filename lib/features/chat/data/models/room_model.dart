import 'package:chat_app/features/chat/data/models/user_model.dart';
import 'package:chat_app/features/chat/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  const RoomModel({
    required super.roomName,
    required super.roomId,
    required super.pin,
    required super.users,
  });

  factory RoomModel.fromJson(Map<String, dynamic>? json) {
    return RoomModel(
      roomName: json?['roomName'] ?? '',
      roomId: json?['roomId'] ?? '',
      pin: json?['pin'] ?? '',
      users:
          (json?['users'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  factory RoomModel.fromJsonForJoinedUser(Map<String, dynamic>? json) {
    return RoomModel(
      roomName: json?['name'] ?? '',
      roomId: json?['id'] ?? '',
      pin: json?['pin'] ?? '',
      users:
          (json?['users'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'roomId': roomId,
      'pin': pin,
      'users': users.map((e) => (e as UserModel).toJson()).toList(),
    };
  }
}
