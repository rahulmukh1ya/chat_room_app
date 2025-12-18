part of 'room_bloc.dart';

enum RoomStatus {
  initial,
  loading,
  loaded,
  roomCreateSuccess,
  roomJoinedSuccess,
  roomLeftSuccess,
  userJoined,
  userLeft,
  error,
}

final class RoomState extends Equatable {
  final RoomEntity? roomEntity;
  final String? roomPIN;
  final List<UserEntity> users;
  final UserEntity? currentUser;
  final UserEntity? joinedUser;
  final UserEntity? leftUser;
  final List<ReceivedMessageEntity> receivedMessages;
  final RoomStatus status;
  final String message;

  const RoomState({
    this.roomEntity,
    this.roomPIN,
    this.currentUser,
    this.joinedUser,
    this.leftUser,
    this.users = const [],
    this.receivedMessages = const [],
    this.status = RoomStatus.initial,
    this.message = '',
  });

  RoomState copyWith({
    RoomEntity? roomEntity,
    String? roomPIN,
    List<UserEntity>? users,
    UserEntity? currentUser,
    UserEntity? joinedUser,
    UserEntity? leftUser,
    List<ReceivedMessageEntity>? receivedMessages,
    RoomStatus? status,
    String? message,
  }) {
    return RoomState(
      roomEntity: roomEntity ?? this.roomEntity,
      roomPIN: roomPIN ?? this.roomPIN,
      users: users ?? this.users,
      currentUser: currentUser ?? this.currentUser,
      joinedUser: joinedUser ?? this.joinedUser,
      leftUser: leftUser ?? this.leftUser,
      receivedMessages: receivedMessages ?? this.receivedMessages,
      status: status ?? this.status,
      message: message ?? '',
    );
  }

  @override
  List<Object?> get props => [
    roomEntity,
    roomPIN,
    currentUser,
    joinedUser,
    leftUser,
    users,
    receivedMessages,
    status,
    message,
  ];
}
