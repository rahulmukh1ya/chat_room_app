import 'package:chat_app/features/chat/domain/entities/message_entity.dart';


abstract class ChatRepository {
  Future<void> connect();
  Stream<MessageEntity> receiveMessages();
  Future<void> sendMessage(String text);
  void dispose();
}


