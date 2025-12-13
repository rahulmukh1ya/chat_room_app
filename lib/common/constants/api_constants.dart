class ApiConstants {
  // static const baseUrl = 'https://chat-app-backend-5xu6.onrender.com';
  // static const wsUrl = 'ws://chat-app-backend-5xu6.onrender.com/ws';

  static const baseUrl = 'http://192.168.1.5:8080';
  static const wsUrl = 'ws://192.168.1.5:8080/ws';

  static const health = '/health';
  static const register = '/register';
  static const login = '/login';
  static const users = '/users';
  static const getUserConversation =
      '/conversations'; // "/conversations/:userId/messages"
}
