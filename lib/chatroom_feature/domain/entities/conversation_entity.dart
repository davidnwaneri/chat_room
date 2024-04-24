import 'package:chatroom/chatroom_feature/domain/entities/message_entity.dart';
import 'package:chatroom/chatroom_feature/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class ConversationEntity extends Equatable {
  const ConversationEntity({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastModified,
    required this.members,
    this.messages,
    this.topic,
  });

  final String id;
  final String name;
  final String? topic;
  final String lastMessage;
  final DateTime lastModified;
  final List<UserEntity> members;
  final List<MessageEntity>? messages;

  ConversationEntity copyWith({
    List<MessageEntity>? messages,
  }) {
    return ConversationEntity(
      id: id,
      name: name,
      lastMessage: lastMessage,
      lastModified: lastModified,
      members: members,
      messages: messages ?? this.messages,
      topic: topic,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        topic,
        lastMessage,
        lastModified,
        members,
        messages,
      ];

  @override
  String toString() {
    return '''
      ${describeIdentity(this)}(
        id: $id,
        name: $name,
        topic: $topic,
        lastModified: $lastModified,
        lastMessage: $lastMessage,
        members: $members,
        messages: $messages,
      )
   ''';
  }
}
