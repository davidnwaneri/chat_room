import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class MessageEntity extends Equatable {
  const MessageEntity({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.sender,
  });

  final String id;
  final String text;
  final String sender;
  final DateTime sentAt;

  @override
  List<Object> get props => [id, text, sentAt, sender];

  @override
  String toString() {
    return '''
      ${describeIdentity(this)}(
        id: $id,
        text: $text,
        sentAt: $sentAt,
        sender: $sender,
      )
    ''';
  }
}
