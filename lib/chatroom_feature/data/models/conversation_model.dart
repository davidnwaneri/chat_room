import 'package:chatroom/chatroom_feature/data/models/user_model.dart';
import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  const ConversationModel({
    required super.id,
    required super.name,
    required super.lastMessage,
    required super.lastModified,
    required super.members,
    super.messages,
    super.topic,
  });

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int?;
    final topic = map['topic'] as String?;
    final lastMessage = map['last_message'] as String?;
    final timestamp = map['modified_at'] as int?;
    final members = map['members'] as List<dynamic>?;

    if (id == null) throw const FormatException('Unable to get conversation id');
    if (lastMessage == null) throw const FormatException('Unable to get last message');
    if (timestamp == null) throw const FormatException('Unable to get last modified date');
    if (members == null) throw const FormatException('Unable to get members');

    try {
      return ConversationModel(
        id: id.toString(),
        name: 'Chatroom $id',
        topic: topic,
        lastMessage: lastMessage,
        lastModified: DateTime.fromMillisecondsSinceEpoch(timestamp),
        members: members.map((e) => UserModel.fromString(e as String)).toList(),
      );
    } on FormatException {
      rethrow;
    } catch (e) {
      throw const FormatException('Unable to get conversation');
    }
  }
}
