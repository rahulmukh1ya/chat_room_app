import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/features/chat/presentation/bloc/pusher_bloc/pusher_bloc.dart';
import 'package:chat_app/features/chat/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PusherBloc, PusherState>(
      listener: (context, state) async {
        await Future.delayed(Duration(seconds: 2));
        if (!context.mounted) return;
        if (state.status == PusherStatus.connected) {
          CustomSnackbar.show(context, state.message, SnackbarType.success);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state.status == PusherStatus.error) {
          CustomSnackbar.show(context, state.message, SnackbarType.error);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            height: 120,
            width: 120,
            'assets/gifs/happy-friends.gif',
          ),
        ),
      ),
    );
  }
}
