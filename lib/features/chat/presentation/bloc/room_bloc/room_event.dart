part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

final class CreateRoomEvent extends RoomEvent {
  final String roomName;
  final String username;

  const CreateRoomEvent({required this.roomName, required this.username});

  @override
  List<Object> get props => [roomName, username];
}

final class LeaveRoomEvent extends RoomEvent {
  final String roomId;
  final String userId;

  const LeaveRoomEvent({required this.roomId, required this.userId});

  @override
  List<Object> get props => [roomId, userId];
}

final class JoinRoomEvent extends RoomEvent {
  final String roomId;
  final String userName;
  final String pin;

  const JoinRoomEvent({
    required this.roomId,
    required this.userName,
    required this.pin,
  });

  @override
  List<Object> get props => [roomId, userName, pin];
}

class MessageSendEvent extends RoomEvent {
  final SentMessageEntity sentMessage;

  const MessageSendEvent({required this.sentMessage});

  @override
  List<Object> get props => [sentMessage];
}

//Stream Events that's fired by listeners

class OnUserJoinedEvent extends RoomEvent {
  final UserEntity joinedUser;

  const OnUserJoinedEvent({required this.joinedUser});

  @override
  List<Object> get props => [joinedUser];
}

class OnUserLeftEvent extends RoomEvent {
  final UserEntity leftUser;

  const OnUserLeftEvent({required this.leftUser});

  @override
  List<Object> get props => [leftUser];
}

class OnMessageReceivedEvent extends RoomEvent {
  final ReceivedMessageEntity receivedMessage;

  const OnMessageReceivedEvent({required this.receivedMessage});

  @override
  List<Object> get props => [receivedMessage];
}

class OnErrorEvent extends RoomEvent {
  final String message;

  const OnErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}
