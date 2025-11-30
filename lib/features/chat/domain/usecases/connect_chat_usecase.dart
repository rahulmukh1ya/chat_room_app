import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ConnectChatUsecase {
  final ChatRepository repository;

  ConnectChatUsecase({required this.repository});

  Future<void> call() {
   return repository.connect();
  }
  
}