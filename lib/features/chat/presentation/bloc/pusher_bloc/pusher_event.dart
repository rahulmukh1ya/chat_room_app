part of 'pusher_bloc.dart';

sealed class PusherEvent extends Equatable {
  const PusherEvent();

  @override
  List<Object> get props => [];
}

final class InitializePusherEvent extends PusherEvent {}

final class DisconnectPusherEvent extends PusherEvent {}
