import 'package:chatroom/chatroom_feature/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.text,
    required super.sentAt,
    required super.sender,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int?;
    final text = map['message'] as String?;
    final sentAt = map['modified_at'] as int?;
    final sender = map['sender'] as String?;

    if (id == null) throw const FormatException('Unable to get message id');
    if (text == null) throw const FormatException('Unable to get message text');
    if (sentAt == null) throw const FormatException('Unable to get message sent date');
    if (sender == null) throw const FormatException('Unable to get message sender');

    try {
      return MessageModel(
        id: id.toString(),
        text: text,
        sentAt: DateTime.fromMillisecondsSinceEpoch(sentAt),
        sender: sender,
      );
    } on FormatException {
      rethrow;
    } catch (e) {
      throw const FormatException('Unable to get message');
    }
  }
}
