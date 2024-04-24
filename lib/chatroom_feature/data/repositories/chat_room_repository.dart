import 'package:chatroom/chatroom_feature/data/datasources/chat_room_remote_data_source.dart';
import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/chatroom_feature/domain/entities/message_entity.dart';
import 'package:chatroom/core/network/failures.dart';
import 'package:chatroom/core/network/network_client_exception.dart';
import 'package:chatroom/core/network/typedefs.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
class ChatRoomRepository {
  const ChatRoomRepository({
    required ChatRoomRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ChatRoomRemoteDataSource _remoteDataSource;

  FutureEither<List<ConversationEntity>> getConversations() async {
    try {
      final conversations = await _remoteDataSource.getConversations();
      return Right(conversations);
    } on NetworkClientException catch (e, st) {
      return Left(ConversationFailure(e.message, stackTrace: st));
    }
  }

  FutureEither<List<MessageEntity>> getMessages(String conversationId) async {
    try {
      final res = await _remoteDataSource.getMessages(conversationId);
      return Right(res);
    } on NetworkClientException catch (e, st) {
      return Left(ConversationFailure(e.message, stackTrace: st));
    }
  }
}
