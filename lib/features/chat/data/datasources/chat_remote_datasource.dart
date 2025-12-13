import 'dart:convert';
import 'dart:developer';
import 'package:chat_app/common/constants/api_constants.dart';
import 'package:chat_app/common/network/dio_http_client.dart';
import 'package:chat_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:chat_app/features/chat/data/models/chat_user_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class ChatRemoteDatasource {
  Future<void> connect();
  Stream<MessageModel> receiveMessages();
  Future<void> sendMessage(String recipientId, String text);
  Future<List<ChatUserModel>> getChatUsers();
  Future<List<MessageModel>> getUserConversation(String userId);
  void dispose();
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final AuthLocalDatasource authLocalDataSource;
  final DioHttpClient client;
  WebSocketChannel? _channel;

  ChatRemoteDatasourceImpl({
    required this.authLocalDataSource,
    required this.client,
  });

  @override
  Future<void> connect() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final uri = Uri(
        scheme: 'ws',
        host: ApiConstants.wsUrl,
        path: '/ws',
        queryParameters: {"token": token},
      );

      _channel = WebSocketChannel.connect(uri);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<MessageModel> receiveMessages() {
    if (_channel == null) {
      throw Exception("WebSocket not connected. Call connect() first.");
    }
    return _channel!.stream.map(
      (event) => MessageModel.fromJson(jsonDecode(event)),
    );
  }

  @override
  Future<void> sendMessage(String recipientId, String text) async {
    if (_channel == null) {
      throw Exception("WebSocket not connected.");
    }
    final payload = jsonEncode({
      "recipient_id": int.parse(recipientId),
      "content": text,
    });
    _channel!.sink.add(payload);
  }

  @override
  void dispose() {
    _channel?.sink.close();
  }

  @override
  Future<List<ChatUserModel>> getChatUsers() async {
    final token = await authLocalDataSource.getAccessToken();

    final response = await client.get(ApiConstants.users, token: token);

    final usersMapList = response['users'];

    log(response.toString());

    final chatUsersList =
        (usersMapList as List<dynamic>?)
            ?.map((e) => ChatUserModel.fromJson(e))
            .toList() ??
        [];

    return chatUsersList;
  }

  @override
  Future<List<MessageModel>> getUserConversation(String userId) async {
    final token = await authLocalDataSource.getAccessToken();

    final response = await client.get(
      "${ApiConstants.getUserConversation}/$userId/messages",
      token: token,
    );

    final data = response['messages'];

    log(response.toString());

    final userMessages =
        (data as List<Map<String, dynamic>>?)
            ?.map((e) => MessageModel.fromJson(e))
            .toList() ??
        [];

    return userMessages;
  }
}
