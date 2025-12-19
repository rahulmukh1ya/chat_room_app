import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/common/constants/pusher_constants.dart';
import 'package:chat_app/features/chat/data/models/received_message_model.dart';
import 'package:chat_app/features/chat/data/models/user_model.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  final PusherChannelsFlutter pusher;

  PusherService({required this.pusher});

  PusherChannel? _channel;

  final _messageController = StreamController<ReceivedMessageModel>.broadcast();
  final _userJoinedController = StreamController<UserModel>.broadcast();
  final _userLeftController = StreamController<UserModel>.broadcast();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) {
      log('Pusher is already initialized');
      return;
    }
    try {
      await pusher.init(
        apiKey: PusherConstants.apiKey,
        cluster: PusherConstants.cluster,
        onConnectionStateChange: (current, previous) {
          log('Pusher: $previous -> $current');
        },
        onError: (message, code, error) {
          log('Pusher error: $message, code: $code, error: $error');
        },
      );

      await pusher.connect();
      _isInitialized = true;
      log('Connected to Pusher');
    } catch (e) {
      log('Pusher init error: $e');
      rethrow;
    }
  }

  Future<void> subscribeToRoom(String roomId) async {
    if (!_isInitialized) {
      throw Exception('Pusher not initialized!!!');
    }

    final channelName = 'chat-$roomId';

    _channel = await pusher.subscribe(
      channelName: channelName,
      onEvent: _handleEvent,
      onSubscriptionSucceeded: (data) {
        log('Successfully subscribed to $channelName');
      },
      onSubscriptionError: (message, error) {
        log('Subscription error for $channelName: $message');
      },
    );
  }

  void _handleEvent(dynamic event) {
    log('Event: ${event.eventName}');

    if (event.data == null) return;

    try {
      final data = event.data is String
          ? jsonDecode(event.data) as Map<String, dynamic>
          : Map<String, dynamic>.from(event.data as Map);

      switch (event.eventName) {
        case 'new-message':
          _messageController.add(ReceivedMessageModel.fromJson(data['data']));
          break;
        case 'user-joined':
          _userJoinedController.add(UserModel.fromJson(data['user']));
          break;
        case 'user-left':
          _userLeftController.add(UserModel.fromJson(data['user']));
          break;
        default:
          log('Unhandled event: ${event.eventName}');
      }
    } catch (e) {
      log('Event parse error: $e');
    }
  }

  Stream<ReceivedMessageModel> get messages => _messageController.stream;
  Stream<UserModel> get userJoined => _userJoinedController.stream;
  Stream<UserModel> get userLeft => _userLeftController.stream;

  Future<void> unsubscribe() async {
    if (_channel != null) {
      // await pusher.unsubscribe(channelName: 'chat-$roomId');
      await pusher.unsubscribe(channelName: _channel!.channelName);
      _channel = null;
      log('Unsubscribed from room');
    }
  }

  Future<void> disconnect() async {
    await unsubscribe();

    await _messageController.close();
    await _userJoinedController.close();
    await _userLeftController.close();

    await pusher.disconnect();
    _isInitialized = false;

    log('Pusher disposed');
  }
}
