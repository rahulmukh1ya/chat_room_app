import 'package:chat_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource chatRemoteDatasource;

  ChatRepositoryImpl({required this.chatRemoteDatasource});

  @override
  Future<void> connect() {
    return chatRemoteDatasource.connect();
  }

  @override
  void dispose() {
    chatRemoteDatasource.dispose();
  }

  @override
  Stream<MessageEntity> receiveMessages() {
    return chatRemoteDatasource.receiveMessages();
  }

  @override
  Future<void> sendMessage(String text) {
    return chatRemoteDatasource.sendMessage(text);
  }
}
