part of 'chat_bloc.dart';

final class ChatState extends Equatable {
  final List<MessageEntity> messages;

  const ChatState({this.messages = const []});

  @override
  List<Object> get props => [messages];
}
