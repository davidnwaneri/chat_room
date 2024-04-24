import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatroomProfileAvatar extends StatelessWidget {
  const ChatroomProfileAvatar({
    this.radius = 20,
    super.key,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: radius,
      child: Icon(
        Iconsax.profile_2user,
        size: radius - 4,
      ),
    );
  }
}
