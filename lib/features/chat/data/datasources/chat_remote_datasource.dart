import 'dart:developer';

import 'package:chat_app/common/constants/api_constants.dart';
import 'package:chat_app/common/network/dio_http_client.dart';
import 'package:chat_app/common/services/pusher_service.dart';
import 'package:chat_app/features/chat/data/models/joined_room_model.dart';
import 'package:chat_app/features/chat/data/models/received_message_model.dart';
import 'package:chat_app/features/chat/data/models/room_model.dart';
import 'package:chat_app/features/chat/data/models/sent_message_model.dart';
import 'package:chat_app/features/chat/data/models/user_model.dart';

abstract class ChatRemoteDatasource {
  Future<void> initializePusher();
  Future<void> disconnectPusher();

  Future<RoomModel> createRoom(String roomName, String username);
  Future<JoinedRoomModel> joinRoom(String roomId, String username);
  Future<bool> leaveRoom(String roomId, String userId);

  Future<bool> sendMessage(SentMessageModel message);

  Stream<ReceivedMessageModel> get messages;
  Stream<UserModel> get userJoined;
  Stream<UserModel> get userLeft;
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final DioHttpClient client;
  final PusherService pusherService;

  ChatRemoteDatasourceImpl({required this.pusherService, required this.client});

  @override
  Future<void> initializePusher() async {
    try {
      await pusherService.init();
    } catch (e) {
      log('Error: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  Future<RoomModel> createRoom(String roomName, String username) async {
    try {
      final responseX = await client.get('/health');

      log(responseX.toString());

      final response = await client.post(
        ApiConstants.createRoom,
        body: {"roomName": roomName, "username": username},
      );

      final roomModel = RoomModel.fromJson(response);

      await pusherService.subscribeToRoom(roomModel.roomId);

      return roomModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<JoinedRoomModel> joinRoom(String roomId, String username) async {
    try {
      final response = await client.post(
        ApiConstants.joinRoom,
        body: {"roomId": roomId, "username": username},
      );

      final joinedRoomModel = JoinedRoomModel.fromJson(response);

      log(joinedRoomModel.toString());

      await pusherService.subscribeToRoom(joinedRoomModel.room.roomId);

      return joinedRoomModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> leaveRoom(String roomId, String userId) async {
    try {
      final response = await client.post(
        ApiConstants.leaveRoom,
        body: {"roomId": roomId, "userId": userId},
      );

      await pusherService.unsubscribe();

      return response['valid'] as bool;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> sendMessage(SentMessageModel message) async {
    try {
      final response = await client.post(
        ApiConstants.sendMessage,
        body: message.toJson(),
      );

      final status = response['status'];

      status.toString().toLowerCase() == 'sent' ? true : false;

      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> disconnectPusher() async {
    try {
      await pusherService.disconnect();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<ReceivedMessageModel> get messages => pusherService.messages;

  @override
  Stream<UserModel> get userJoined => pusherService.userJoined;

  @override
  Stream<UserModel> get userLeft => pusherService.userLeft;
}
