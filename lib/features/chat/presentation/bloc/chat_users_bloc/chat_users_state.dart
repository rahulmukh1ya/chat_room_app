part of 'chat_users_bloc.dart';

enum ChatUsersStatus { initial, loading, loaded, error }

final class ChatUsersState extends Equatable {
  final ChatUsersStatus status;
  final String message;
  final List<ChatUserEntity> chatUsers;
  const ChatUsersState({
    this.status = ChatUsersStatus.initial,
    this.message = '',
    this.chatUsers = const [],
  });

  ChatUsersState copyWith({
    ChatUsersStatus? status,
    String? message,
    List<ChatUserEntity>? chatUsers,
  }) {
    return ChatUsersState(
      status: status ?? this.status,
      message: message ?? '',
      chatUsers: chatUsers ?? this.chatUsers,
    );
  }

  @override
  List<Object?> get props => [status, message, chatUsers];
}
