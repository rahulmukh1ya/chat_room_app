import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class DisposeChatUsecase {
  final ChatRepository repository;

  DisposeChatUsecase({required this.repository});

  void dispose() {
    return repository.dispose();
  }
}
