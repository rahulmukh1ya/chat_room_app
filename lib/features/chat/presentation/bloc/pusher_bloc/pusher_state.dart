part of 'pusher_bloc.dart';

enum PusherStatus { initial, loading, connected, disconnected, error }

final class PusherState extends Equatable {
  final PusherStatus status;
  final String message;
  const PusherState({this.status = PusherStatus.initial, this.message = ''});

  PusherState copyWith({PusherStatus? status, String? message}) {
    return PusherState(status: status ?? this.status, message: message ?? '');
  }

  @override
  List<Object> get props => [status, message];
}
