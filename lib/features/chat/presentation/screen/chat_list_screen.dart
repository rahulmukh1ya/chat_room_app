import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat List Screen'), centerTitle: true),
      body: Center(child: Text('This is the chat list screen')),
    );
  }
}
