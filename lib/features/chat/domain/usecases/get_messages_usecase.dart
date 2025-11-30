import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class GetMessagesUsecase {
  final ChatRepository repository;

  GetMessagesUsecase({required this.repository});

  Stream<MessageEntity> call() {
    return repository.receiveMessages();
  }
}
