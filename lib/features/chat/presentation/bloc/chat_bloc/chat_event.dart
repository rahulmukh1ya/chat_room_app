part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatConnectEvent extends ChatEvent {}


class GetUserConversationEvent extends ChatEvent {
  final String userId;

  const GetUserConversationEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class MessageReceivedEvent extends ChatEvent {
  final MessageEntity message;

  const MessageReceivedEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSentEvent extends ChatEvent {
  final String recipientId;
  final String text;

  const MessageSentEvent({required this.recipientId, required this.text});

  @override
  List<Object> get props => [text];
}

class ChatDisposeEvent extends ChatEvent {}
