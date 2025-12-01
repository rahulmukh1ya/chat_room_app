part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatConnectEvent extends ChatEvent {}

class MessageReceivedEvent extends ChatEvent {
  final MessageEntity message;

  const MessageReceivedEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSentEvent extends ChatEvent {
  final String text;

  const MessageSentEvent({required this.text});

  @override
  List<Object> get props => [text];
}

class ChatDisposeEvent extends ChatEvent {}
