import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      iconData: Icons.forum_outlined,
                      title: 'Create Room',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: ButtonWidget(
                      iconData: Icons.person_add_outlined,
                      title: 'Join Room',
                      onTap: () {},
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
