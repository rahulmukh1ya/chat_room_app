import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/features/chat/domain/entities/sent_message_entity.dart';
import 'package:chat_app/features/chat/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage(BuildContext context, RoomState state) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final message = SentMessageEntity(
      roomId: state.roomEntity!.roomId,
      userId: state.currentUser!.userId,
      username: state.currentUser!.username,
      encryptedMessage: text,
      timestamp: DateTime.now().toIso8601String(),
    );

    context.read<RoomBloc>().add(MessageSendEvent(sentMessage: message));
    _messageController.clear();

    Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
  }

  void _leaveRoom(BuildContext context, RoomState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Leave Room'),
        content: Text('Are you sure you want to leave this room?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<RoomBloc>().add(
                LeaveRoomEvent(
                  roomId: state.roomEntity!.roomId,
                  userId: state.currentUser!.userId,
                ),
              );
              Navigator.pop(ctx);
            },
            child: Text('Leave', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, state) {
        switch (state.status) {
          case RoomStatus.error:
            CustomSnackbar.show(context, state.message, SnackbarType.error);
            break;
          case RoomStatus.roomLeftSuccess:
            CustomSnackbar.show(
              context,
              'Left room successfully',
              SnackbarType.success,
            );
            Navigator.pop(context);
            break;
          case RoomStatus.userJoined:
            CustomSnackbar.show(
              context,
              '${state.joinedUser?.username ?? 'Someone'} joined',
              SnackbarType.info,
            );
            break;
          case RoomStatus.userLeft:
            CustomSnackbar.show(
              context,
              '${state.leftUser?.username ?? 'Someone'} left',
              SnackbarType.info,
            );
            break;
          case RoomStatus.loaded:
            _scrollToBottom();
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        if (state.status == RoomStatus.loading ||
            state.status == RoomStatus.initial) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state.roomEntity == null || state.currentUser == null) {
          return Scaffold(body: Center(child: Text('Room not found')));
        }

        final room = state.roomEntity!;
        final currentUser = state.currentUser!;
        final messages = state.receivedMessages;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${room.roomName} ( ${room.roomId} )",
                  style: TextStyle(fontSize: 18, letterSpacing: 1.5),
                ),
                if (room.pin != '')
                  Text(
                    'PIN: ${room.pin}',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => _leaveRoom(context, state),
                tooltip: 'Leave Room',
              ),
            ],
          ),
          body: Column(
            children: [
              // Messages List
              Expanded(
                child: messages.isEmpty
                    ? Center(
                        child: Text(
                          'No messages yet.\nStart the conversation!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message.userId == currentUser.userId;

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Colors.blue[600]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomLeft: isMe
                                      ? Radius.circular(16)
                                      : Radius.circular(4),
                                  bottomRight: isMe
                                      ? Radius.circular(4)
                                      : Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (!isMe)
                                    Text(
                                      message.username,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  if (!isMe) SizedBox(height: 4),
                                  Text(
                                    message.decryptedMessage,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: isMe ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _formatTime(message.timestamp),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isMe
                                          ? Colors.white70
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Message Input
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            // filled: true,
                            // fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(context, state),
                        ),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.blue[600],
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.white, size: 20),
                          onPressed: () => _sendMessage(context, state),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
    );

    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');

    if (messageDate == today) {
      return '$hour:$minute';
    } else {
      return '${timestamp.day}/${timestamp.month} $hour:$minute';
    }
  }
}
