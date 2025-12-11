import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {

//   {
//   "id": 123,
//   "user_id": 1,
//   "recipient_id": 2,
//   "username": "john_doe",
//   "content": "Hello!",
//   "created_at": "2025-12-05T12:30:00Z"
// }


  final int id;
  final int userId;
  final String username;
  final String content;
  final DateTime createdAt;

  const MessageEntity({
    required this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, username, content, createdAt];
}
