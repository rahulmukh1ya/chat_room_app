import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/features/chat/domain/entities/sent_message_entity.dart';
import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app/features/chat/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_card.dart';
import 'package:chat_app/features/chat/presentation/widgets/message_input_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
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

  void _sendMessage(
    BuildContext context,
    RoomState state,
    String? thisMessage,
  ) {
    if (thisMessage == null || thisMessage == '') return;

    final message = SentMessageEntity(
      roomId: state.roomEntity!.roomId,
      userId: state.currentUser!.userId,
      username: state.currentUser!.username,
      encryptedMessage: thisMessage,
      timestamp: DateTime.now().toIso8601String(),
    );

    context.read<RoomBloc>().add(MessageSendEvent(sentMessage: message));

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

  void _showUsersDialog(BuildContext context, List<UserEntity> users) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Users in room'),
        content: SizedBox(
          width: double.maxFinite,
          child: users.isEmpty
              ? const Text('No users in the room')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.person, size: 26),
                          Text(user.username, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
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
            CustomSnackbar.show(context, state.message, SnackbarType.success);
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

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: Center(
                child: InkWell(
                  onTap: () {
                    _showUsersDialog(context, state.users);
                  },
                  child: Badge(
                    offset: Offset(10, -7),
                    label: Text(state.users.length.toString()),
                    child: Icon(Icons.groups_outlined),
                  ),
                ),
              ),
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

                            return ChatCard(isMe: isMe, message: message);
                          },
                        ),
                ),

                // Message Input
                MessageInputBox(
                  onSend: (value) {
                    _sendMessage(context, state, value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
