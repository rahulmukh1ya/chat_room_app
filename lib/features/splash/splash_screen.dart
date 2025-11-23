import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/screen/login_screen.dart';
import 'package:chat_app/features/chat/presentation/screen/chat_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        await Future.delayed(Duration(seconds: 2));
        if (!context.mounted) return;
        if (state.status == AuthStatus.userAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChatListScreen()),
          );
        } else if (state.status == AuthStatus.userUnauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state.status == AuthStatus.authenticationError) {
          CustomSnackbar.show(context, state.message, SnackbarType.error);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          CustomSnackbar.show(
            context,
            'Unknown error occured',
            SnackbarType.error,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: LottieBuilder.asset(
            height: 120,
            width: 120,
            'assets/lottie/loader.json',
          ),
        ),
      ),
    );
  }
}
