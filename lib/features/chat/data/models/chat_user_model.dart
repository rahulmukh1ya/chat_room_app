import 'package:chat_app/features/chat/domain/entities/user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  ChatUserModel({
    required super.id,
    required super.username,
    required super.createdAt,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'],
      username: json['username'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
