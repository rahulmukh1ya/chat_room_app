import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUsecase {
  final ChatRepository repository;

  SendMessageUsecase({required this.repository});

  Future<void> call(String text) {
    return repository.sendMessage(text);
  }
}
