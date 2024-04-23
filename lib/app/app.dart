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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
