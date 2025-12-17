import 'package:equatable/equatable.dart';

class ReceivedMessageEntity extends Equatable {
  final String decryptedMessage;
  final String userId;
  final String username;
  final DateTime timestamp;

  const ReceivedMessageEntity({
    required this.decryptedMessage,
    required this.userId,
    required this.username,
    required this.timestamp,
  });

  @override
  List<Object> get props => [timestamp, decryptedMessage, userId, username];
}


// {
//   "data": {
//     "encryptedMessage": "TestMessage123",
//     "timestamp": "2024-01-15T10:30:00Z",
//     "userId": "",
//     "username": "Alice"
//   },
//   "type": "new-message"
// }