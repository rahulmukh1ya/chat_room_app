class ApiConstants {
  // static const baseUrl = 'http://localhost:8080';
  static const baseUrl = 'http://192.168.1.16:8080';

  static const createRoom = '/create-room';
  static const sendMessage = '/send-message';
  static const joinRoom = '/join-room';
  static const leaveRoom = '/leave-room';

  //Pusher Events
  static const onNewMessageEvent = 'new-message';
  static const onUserJoinedEvent = 'user-joined';
  static const onUserLeftEvent = 'user-left';
}
