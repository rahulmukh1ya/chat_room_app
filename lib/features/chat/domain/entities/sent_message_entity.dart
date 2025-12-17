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

  @override
  List<Object> get props => [
    roomId,
    encryptedMessage,
    userId,
    username,
    timestamp,
  ];
}
