import 'package:chatroom/app/app_theme.dart';
import 'package:chatroom/chatroom_feature/presentations/view/home_screen.dart';
import 'package:flutter/material.dart';

class ChatRoomApp extends StatelessWidget {
  const ChatRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatroom',
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == HomeScreen.routeName) {
          return HomeScreen.route(settings);
        } else {
          return null;
        }
      },
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
