import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/core/formatters.dart';
import 'package:chatroom/utils/padding_constants.dart';
import 'package:chatroom/utils/widget_library/widget_library.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({
    required this.conversation,
    required this.onTap,
    super.key,
  });

  final ConversationEntity conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const border = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    return InkWell(
      customBorder: border,
      onTap: onTap,
      child: Padding(
        padding: allPadding12,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Iconsax.profile_2user,
                  size: 16,
                ),
              ),
              const Space(10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: conversation.id,
                      child: Text(
                        conversation.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Space(4),
                    Text(
                      conversation.lastMessage,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.grey.shade400,
                          ),
                    ),
                  ],
                ),
              ),
              const Space(10),
              Text(
                dateToTimeAgo(conversation.lastModified),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.grey.shade400,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
