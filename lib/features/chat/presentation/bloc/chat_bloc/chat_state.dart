part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, loaded, error }

final class ChatState extends Equatable {
  final List<MessageEntity> messages;
  final String? error;
  final ChatStatus status;

  const ChatState({
    this.messages = const [],
    this.error = '',
    this.status = ChatStatus.initial,
  });

  ChatState copyWith({
    List<MessageEntity>? messages,
    String? error,
    ChatStatus? status,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      error: error ?? '',
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [messages, error, status];
}
