import 'package:equatable/equatable.dart';

class SentMessageEntity extends Equatable {
  final String roomId;
  final String encryptedMessage;
  final String userId;
  final String username;
  final String timestamp;

  const SentMessageEntity({
    required this.roomId,
    required this.encryptedMessage,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  SentMessageEntity copyWith({
    String? roomId,
    String? encryptedMessage,
    String? userId,
    String? username,
    String? timestamp,
  }) {
    return SentMessageEntity(
      roomId: roomId ?? this.roomId,
      encryptedMessage: encryptedMessage ?? this.encryptedMessage,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object> get props => [
    roomId,
    encryptedMessage,
    userId,
    username,
    timestamp,
  ];
}
