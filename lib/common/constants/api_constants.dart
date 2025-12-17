class ApiConstants {
  static const baseUrl = 'http://localhost:8080';

  static const createRoom = '/create-room';
  static const sendMessage = '/sendMessage';
  static const joinRoom = '/join-room';
  static const leaveRoom = '/leave-room';

  //Pusher Events
  static const onNewMessageEvent = 'new-message';
  static const onUserJoinedEvent = 'user-joined';
  static const onUserLeftEvent = 'user-left';
}
