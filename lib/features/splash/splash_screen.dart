import 'package:chat_app/features/chat/presentation/bloc/pusher_bloc/pusher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PusherBloc, PusherState>(

      listener: (context, state) {
        if(state.status == PusherStatus.connected) {

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
