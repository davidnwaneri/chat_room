import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/chatroom_feature/domain/entities/user_entity.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/conversation_widget.dart';
import 'package:chatroom/core/padding_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // ignore: unused_element
  const HomeScreen._({super.key});

  static const routeName = '/home';

  static Route<void> route(RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeTransition(
          opacity: animation,
          child: const HomeScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        titleSpacing: 0,
        title: Padding(
          padding: leftPadding12,
          child: Text(
            'Chatroom',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          final conversation = ConversationEntity(
            id: '$index',
            topic: 'Around the world in 80 days',
            lastMessage: 'Just got back from Maldives',
            lastModified: DateTime(2024, 04, 20),
            members: [
              UserEntity(id: '${index + 1}', name: 'John doe'),
            ],
          );
          return ConversationWidget(
            conversation: conversation,
            onTap: () {},
          );
        },
      ),
    );
  }
}
