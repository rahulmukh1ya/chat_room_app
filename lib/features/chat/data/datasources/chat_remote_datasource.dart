import 'dart:convert';
import 'package:chat_app/common/constants/api_constants.dart';
import 'package:chat_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class ChatRemoteDatasource {
  Future<void> connect();
  Stream<MessageModel> receiveMessages();
  Future<void> sendMessage(String text);
  void dispose();
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final AuthLocalDatasource authLocalDataSource;
  WebSocketChannel? _channel;

  ChatRemoteDatasourceImpl({required this.authLocalDataSource});

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
  Future<void> sendMessage(String text) async {
    if (_channel == null) {
      throw Exception("WebSocket not connected. Call connect() first.");
    }
    final payload = jsonEncode({"content": text});
    _channel!.sink.add(payload);
  }

  @override
  void dispose() {
    _channel?.sink.close();
  }
}
