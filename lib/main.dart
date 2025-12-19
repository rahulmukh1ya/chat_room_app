import 'package:chat_app/common/di/injection.dart';
import 'package:chat_app/common/theme/theme_class.dart';
import 'package:chat_app/features/chat/presentation/bloc/pusher_bloc/pusher_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:chat_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<PusherBloc>()..add(InitializePusherEvent()),
        ),
        BlocProvider(create: (context) => getIt<RoomBloc>()),
      ],
      child: MaterialApp(
        title: 'E2EE Chat App',
        debugShowCheckedModeBanner: false,
        theme: ChatAppTheme.lightTheme,
        darkTheme: ChatAppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
