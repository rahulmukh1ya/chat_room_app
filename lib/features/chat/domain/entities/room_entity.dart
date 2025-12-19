import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final String roomName;
  final String roomId;
  final String pin;
  final List<UserEntity> users;

  const RoomEntity({
    required this.roomName,
    required this.roomId,
    required this.pin,
    required this.users,
  });

  @override
  String toString() {
    return 'RoomEntity { '
        'roomName: $roomName, '
        'roomId: $roomId, '
        'pin: $pin, '
        'users: $users '
        '}';
  }

  @override
  List<Object> get props => [roomName, roomId, pin, users];
}
