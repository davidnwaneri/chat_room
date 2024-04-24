import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: Colors.grey,
      child: Icon(
        Iconsax.user,
        size: 16,
      ),
    );
  }
}
