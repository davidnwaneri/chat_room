import 'package:chatroom/chatroom_feature/domain/entities/message_entity.dart';
import 'package:chatroom/core/formatters.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    super.key,
  });

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    final borderRadius = (message.id == 'me')
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(20),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(12),
          );

    return Align(
      alignment: (message.id == 'me') ? Alignment.centerRight : Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.sender,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.blueGrey,
                    ),
              ),
              Text(message.text),
              Text(
                formatDate(message.sentAt),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey.shade300,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
