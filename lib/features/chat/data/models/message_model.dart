import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.messageId,
    required super.senderId,
    required super.receiverId,
    required super.senderName,
    required super.receivedMessage,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      senderId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse(json['user_id'].toString()) ?? 0,
      receiverId: json['recipient_id'] is int
          ? json['recipient_id']
          : int.tryParse(json['recipient_id'].toString()) ?? 0,
      senderName: json['username'] ?? 'Unknown',
      receivedMessage: json['content'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': messageId,
      'user_id': senderId,
      'recipient_id': receiverId,
      'username': senderName,
      'content': receivedMessage,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
