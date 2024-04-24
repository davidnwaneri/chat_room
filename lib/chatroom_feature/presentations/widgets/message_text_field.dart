import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide.none,
    );
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.surface,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        hintText: 'Type a message',
      ),
    );
  }
}
