import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
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
