import 'package:chatroom/chatroom_feature/domain/entities/user_entity.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/user_profile_avatar.dart';
import 'package:chatroom/utils/padding_constants.dart';
import 'package:chatroom/utils/widget_library/widget_library.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.user,
    super.key,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allPadding12,
      child: IntrinsicHeight(
        child: Row(
          children: [
            const UserProfileAvatar(),
            const Space(10),
            Expanded(
              child: Text(
                user.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
