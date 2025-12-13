import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';

abstract class ChatRepository {
  Future<void> connect();
  Future<List<ChatUserEntity>> getChatUsers();
  Future<List<MessageEntity>> getUserConversation(String userId);
  Stream<MessageEntity> receiveMessages();
  Future<void> sendMessage(String recipientId, String text);
  void dispose();
}
