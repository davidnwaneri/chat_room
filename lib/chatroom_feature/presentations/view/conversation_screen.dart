import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/message_text_field.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/message_widget.dart';
import 'package:chatroom/utils/padding_constants.dart';
import 'package:chatroom/utils/widget_library/widget_library.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ConversationScreen extends StatefulWidget {
  // ignore: unused_element
  const ConversationScreen._({
    required this.conversation,
    super.key,
  });

  final ConversationEntity conversation;

  static const routeName = '/conversation';

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
          child: ConversationScreen._(
            conversation: settings.arguments! as ConversationEntity,
          ),
        );
      },
    );
  }

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismissKeyboard,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: InkWell(
            onTap: () {},
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Iconsax.profile_2user,
                      size: 16,
                    ),
                  ),
                  const Space(5),
                  Hero(
                    tag: widget.conversation.id,
                    transitionOnUserGestures: true,
                    child: Text(widget.conversation.name),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: horizontalPadding12 + const EdgeInsets.only(bottom: 4),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return MessageWidget();
                  },
                ),
              ),
              MessageTextField(
                controller: _textController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
