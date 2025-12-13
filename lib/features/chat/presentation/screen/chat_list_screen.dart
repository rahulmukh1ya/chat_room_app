import 'package:chat_app/common/di/injection.dart';
import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/features/auth/presentation/screen/login_screen.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_users_bloc/chat_users_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        'Chat Users List',
        style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2),
      ),
      centerTitle: true,
      actions: [_logoutButton(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatUsersBloc>()..add(GetChatUsersEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<ChatBloc>()..add(ChatConnectEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: _appBar(context),
            body: BlocConsumer<ChatUsersBloc, ChatUsersState>(
              listener: (context, state) {
                if (state.status == ChatUsersStatus.error) {
                  CustomSnackbar.show(
                    context,
                    state.message,
                    SnackbarType.error,
                  );
                }
              },
              builder: (context, state) {
                if (state.status == ChatUsersStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  );
                } else if (state.chatUsers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Text('No Chat Users Found.'),
                        InkWell(
                          onTap: () {
                            context.read<ChatUsersBloc>().add(
                              GetChatUsersEvent(),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh, size: 18),
                              Text(
                                'Refresh',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.chatUsers.length,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  itemBuilder: (context, index) {
                    final chatUser = state.chatUsers[index];
                    return ChatCard(chatUser: chatUser);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
