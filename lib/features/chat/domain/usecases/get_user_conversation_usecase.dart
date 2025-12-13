import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class GetUserConversationUsecase {
  final ChatRepository repository;

  GetUserConversationUsecase({required this.repository});

  Future<List<MessageEntity>> call(String userId) {
    return repository.getUserConversation(userId);
  }
}
