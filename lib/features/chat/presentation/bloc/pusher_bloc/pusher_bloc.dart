import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'pusher_event.dart';
part 'pusher_state.dart';

class PusherBloc extends Bloc<PusherEvent, PusherState> {
  final ChatRepository chatRepository;
  PusherBloc({required this.chatRepository}) : super(PusherState()) {
    on<InitializePusherEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: PusherStatus.loading));

        await chatRepository.initializePusher();

        emit(state.copyWith(status: PusherStatus.connected));
      } catch (e) {
        emit(state.copyWith(status: PusherStatus.error, message: e.toString()));
      }
    });

    on<DisconnectPusherEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: PusherStatus.loading));

        await chatRepository.disconnectPusher();

        emit(state.copyWith(status: PusherStatus.disconnected));
      } catch (e) {
        emit(state.copyWith(status: PusherStatus.error, message: e.toString()));
      }
    });
  }
}
