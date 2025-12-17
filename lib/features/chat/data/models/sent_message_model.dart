import '../../domain/entities/sent_message_entity.dart';

class SentMessageModel extends SentMessageEntity {
  const SentMessageModel({
    required super.roomId,
    required super.encryptedMessage,
    required super.userId,
    required super.username,
    required super.timestamp,
  });

  factory SentMessageModel.fromEntity(SentMessageEntity entity) {
    return SentMessageModel(
      roomId: entity.roomId,
      encryptedMessage: entity.encryptedMessage,
      userId: entity.userId,
      username: entity.username,
      timestamp: entity.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'encryptedMessage': encryptedMessage,
      'userId': userId,
      'username': username,
      'timestamp': timestamp,
    };
  }
}
