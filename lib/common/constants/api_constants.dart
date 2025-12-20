class ApiConstants {
  // static const baseUrl = 'http://localhost:8080';
  static const baseUrl = 'https://curably-unconciliatory-ernesto.ngrok-free.dev';

  static const createRoom = '/create-room';
  static const sendMessage = '/send-message';
  static const joinRoom = '/join-room';
  static const leaveRoom = '/leave-room';

  //Pusher Events
  static const onNewMessageEvent = 'new-message';
  static const onUserJoinedEvent = 'user-joined';
  static const onUserLeftEvent = 'user-left';
}
