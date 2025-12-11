part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, loaded, error }

final class ChatState extends Equatable {
  final List<MessageEntity> messages;
  final String? error;
  final ChatStatus status;
  final List<ChatUserEntity> chatUsers;

  const ChatState({
    this.messages = const [],
    this.error = '',
    this.status = ChatStatus.initial,
    this.chatUsers = const [],
  });

  ChatState copyWith({
    List<MessageEntity>? messages,
    String? error,
    ChatStatus? status,
    List<ChatUserEntity>? chatUsers,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      error: error ?? '',
      status: status ?? this.status,
      chatUsers: chatUsers ?? this.chatUsers,
    );
  }

  @override
  List<Object?> get props => [messages, error, status, chatUsers];
}
