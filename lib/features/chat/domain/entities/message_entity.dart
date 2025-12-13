import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  //   {
  //   "id": 123, //message id
  //   "user_id": 1, //sender id
  //   "recipient_id": 2, //receiver id
  //   "username": "john_doe", //sender name
  //   "content": "Hello!", // content sent by sender
  //   "created_at": "2025-12-05T12:30:00Z"
  // }

  final int messageId;
  final int senderId;
  final int receiverId;
  final String senderName;
  final String receivedMessage;
  final DateTime createdAt;

 const  MessageEntity({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receivedMessage,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [messageId, senderId, receiverId, senderName, receivedMessage, createdAt];
}
