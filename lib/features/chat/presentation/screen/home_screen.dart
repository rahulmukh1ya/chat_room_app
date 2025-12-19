import 'package:chat_app/features/chat/presentation/widgets/create_room_dialogue.dart';
import 'package:chat_app/features/chat/presentation/widgets/join_room_dialogue.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showCreateRoomDialogue(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CreateRoomDialogue();
      },
    );
  }

  Future<void> _showJoinRoomDialogue(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return JoinRoomDialogue();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E2EE Chat App', style: TextStyle(letterSpacing: 1.5)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: ButtonWidget(
                      iconData: Icons.groups_outlined,
                      title: 'Create Room',
                      onTap: () {
                        _showCreateRoomDialogue(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: ButtonWidget(
                      iconData: Icons.person_add_outlined,
                      title: 'Join Room',
                      onTap: () {
                        _showJoinRoomDialogue(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            spacing: 7,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(iconData), Text(title)],
          ),
        ),
      ),
    );
  }
}
