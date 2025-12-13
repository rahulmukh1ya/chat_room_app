import 'package:chat_app/features/chat/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  final ChatUserEntity chatUser;
  const ChatCard({super.key, required this.chatUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),

      child: Row(
        spacing: 12,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person, color: Colors.black),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(chatUser.username),
              Text("ID: ${chatUser.id.toString()}"),
              Text(
                "Joined: ${DateFormat('h:mm a, MMM d, y').format(chatUser.createdAt.toLocal())}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
