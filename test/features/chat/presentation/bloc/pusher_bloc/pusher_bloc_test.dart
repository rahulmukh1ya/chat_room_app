import 'package:bloc_test/bloc_test.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/features/chat/presentation/bloc/pusher_bloc/pusher_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late PusherBloc pusherBloc;
  late MockChatRepository chatRepository;

  setUp(() {
    chatRepository = MockChatRepository();

    pusherBloc = PusherBloc(chatRepository: chatRepository);
  });

  tearDown(() async {
    await pusherBloc.close();
  });

  test('initial state is correct', () {
    expect(
      pusherBloc.state,
      PusherState(status: PusherStatus.initial, message: ''),
    );
  });

  blocTest<PusherBloc, PusherState>(
    'emits [loading, connected] when InitializePusherEvent succeeds.',
    build: () {
      when(() => chatRepository.initializePusher()).thenAnswer((_) async {});

      return pusherBloc;
    },

    act: (bloc) => bloc.add(InitializePusherEvent()),
    expect: () => [
      isA<PusherState>().having(
        (s) => s.status,
        'status',
        PusherStatus.loading,
      ),

      const PusherState(
        status: PusherStatus.connected,
        message: 'Pusher connected successfully.',
      ),
    ],
    verify: (bloc) {
      verify(() => chatRepository.initializePusher()).called(1);
    },
  );

  blocTest<PusherBloc, PusherState>(
    'emits [loading, error] with error message when initialize pusher event fails',
    build: () {
      when(
        () => chatRepository.initializePusher(),
      ).thenThrow(Exception('connection failed'));
      return pusherBloc;
    },
    act: (bloc) => bloc.add(InitializePusherEvent()),
    expect: () => [
      isA<PusherState>().having(
        (s) => s.status,
        'status',
        PusherStatus.loading,
      ),

      isA<PusherState>()
          .having((s) => s.status, 'status', PusherStatus.error)
          .having((s) => s.message, 'message', contains('connection failed')),
    ],

    verify: (bloc) {
      verify(() => chatRepository.initializePusher()).called(1);
    },
  );

  blocTest<PusherBloc, PusherState>(
    'emits [loading, disconnected] when DisconnectPusherEvent succeeds.',
    build: () {
      when(() => chatRepository.disconnectPusher()).thenAnswer((_) async {});
      return pusherBloc;
    },
    act: (bloc) => bloc.add(DisconnectPusherEvent()),
    expect: () => [
      isA<PusherState>().having(
        (s) => s.status,
        'status',
        PusherStatus.loading,
      ),

      const PusherState(status: PusherStatus.disconnected, message: ''),
    ],

    verify: (bloc) {
      verify(() => chatRepository.disconnectPusher()).called(1);
    },
  );

  blocTest<PusherBloc, PusherState>(
    'emits [loading, error] when DisconnectPusherEvent fails.',
    build: () {
      when(
        () => chatRepository.disconnectPusher(),
      ).thenThrow(Exception('Disconnect Failed'));
      return pusherBloc;
    },
    act: (bloc) => bloc.add(DisconnectPusherEvent()),
    expect: () => [
      isA<PusherState>().having(
        (s) => s.status,
        'status',
        PusherStatus.loading,
      ),

      isA<PusherState>()
          .having((s) => s.status, 'status', PusherStatus.error)
          .having((s) => s.message, 'message', contains('Disconnect Failed')),
    ],

    verify: (bloc) {
      verify(() => chatRepository.disconnectPusher()).called(1);
    },
  );
}
