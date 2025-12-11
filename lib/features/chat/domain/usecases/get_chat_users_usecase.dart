import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class GetChatUsersUsecase {
  final ChatRepository repository;

  GetChatUsersUsecase({required this.repository});

  Future<List<ChatUserEntity>> call() {
    return repository.getChatUsers();
  }
}
