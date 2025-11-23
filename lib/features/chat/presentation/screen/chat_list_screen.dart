import 'package:chat_app/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  Widget _logoutButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showLogoutConfirmDialogue(context),
      icon: Icon(Icons.logout_outlined),
    );
  }

  Future<void> _showLogoutConfirmDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Do you really want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Buddy List',
        style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2),
      ),
      centerTitle: true,
      actions: [_logoutButton(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(child: Text('This is the chat list screen')),
    );
  }
}
