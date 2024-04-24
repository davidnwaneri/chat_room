import 'package:chatroom/app/app_theme.dart';
import 'package:chatroom/chatroom_feature/presentations/view/chatroom_details_screen.dart';
import 'package:chatroom/chatroom_feature/presentations/view/conversation_screen.dart';
import 'package:chatroom/chatroom_feature/presentations/view/home_screen.dart';
import 'package:flutter/foundation.dart';
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
        } else if (settings.name == ConversationScreen.routeName) {
          return ConversationScreen.route(settings);
        } else if (settings.name == ChatroomDetailsScreen.routeName) {
          return ChatroomDetailsScreen.route(settings);
        } else {
          return null;
        }
      },
      scrollBehavior: _scrollBehavior,
    );
  }

  ScrollBehavior? get _scrollBehavior {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    if (isIOS) {
      return null;
    } else {
      return const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      );
    }
  }
}
