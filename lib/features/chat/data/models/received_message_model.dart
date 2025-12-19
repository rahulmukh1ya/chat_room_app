
import 'package:chat_app/features/chat/domain/entities/received_message_entity.dart';

class ReceivedMessageModel extends ReceivedMessageEntity {
  const ReceivedMessageModel({
    required super.decryptedMessage,
    required super.userId,
    required super.username,
    required super.timestamp,
  });

  factory ReceivedMessageModel.fromJson(Map<String, dynamic>? json) {
    return ReceivedMessageModel(
      decryptedMessage: json?['encryptedMessage'] ?? '',
      userId: json?['userId'] ?? '',
      username: json?['username'] ?? '',
      timestamp: json?['timestamp'] != null
          ? DateTime.parse(json!['timestamp'] as String)
          : DateTime.now(),
    );
  }
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