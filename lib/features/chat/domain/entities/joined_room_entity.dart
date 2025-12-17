import 'package:chat_app/features/chat/domain/entities/room_entity.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class JoinedRoomEntity extends Equatable {
  final RoomEntity room;
  final UserEntity currentUser;

  const JoinedRoomEntity({required this.room, required this.currentUser});

  @override
  List<Object> get props => throw [room, currentUser];
}
