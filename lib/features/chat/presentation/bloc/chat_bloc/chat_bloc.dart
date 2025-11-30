import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  
  ChatBloc() : super(ChatState()) {
    on<ListenToMessagesEvent>((event, emit) {
     
    });
  }
}
