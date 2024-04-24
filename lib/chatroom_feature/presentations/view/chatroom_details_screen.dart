import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/chatroom_profile_avatar.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/user_tile.dart';
import 'package:chatroom/utils/padding_constants.dart';
import 'package:chatroom/utils/widget_library/widget_library.dart';
import 'package:flutter/material.dart';

class ChatroomDetailsScreen extends StatelessWidget {
  const ChatroomDetailsScreen._({
    required this.conversation,
    // ignore: unused_element
    super.key,
  });

  final ConversationEntity conversation;

  static const routeName = '/chatroom-details';

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
          child: ChatroomDetailsScreen._(
            conversation: settings.arguments! as ConversationEntity,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const ChatroomProfileAvatar(radius: 50),
                Text(
                  conversation.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (conversation.topic case final String topic)
                  Text(
                    topic,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
              ],
            ),
          ),
          const SliverSpace(20),
          SliverMainAxisGroup(
            slivers: [
              SliverPadding(
                padding: horizontalPadding12 + const EdgeInsets.only(left: 4),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(conversation.members.length.toString()),
                      const Space(10),
                      const Text('Members'),
                    ],
                  ),
                ),
              ),
              SliverList.builder(
                itemCount: conversation.members.length,
                itemBuilder: (context, index) {
                  final member = conversation.members[index];
                  return UserTile(user: member);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
