import 'package:chatroom/chatroom_feature/data/models/conversation_model.dart';
import 'package:chatroom/chatroom_feature/data/models/message_model.dart';
import 'package:chatroom/core/network/network_client.dart';
import 'package:chatroom/core/network/network_client_exception.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ChatRoomRemoteDataSource {
  const ChatRoomRemoteDataSource({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<List<ConversationModel>> getConversations() async {
    try {
      final res = await _networkClient.get(
        const String.fromEnvironment('CONVERSATIONS_URL'),
      );
      final data = res.data!['data'] as List<dynamic>;

      final conversations = data
          .map(
            (e) => ConversationModel.fromMap(e as Map<String, dynamic>),
          )
          .toList();
      return conversations;
    } on NetworkClientException {
      rethrow;
    } on FormatException catch (e, st) {
      throw NetworkClientException(e.message, stackTrace: st);
    }
  }

  Future<List<MessageModel>> getMessages(String conversationId) async {
    try {
      final res = await _networkClient.get(
        String.fromEnvironment('CONVERSATIONS_URL/$conversationId'),
      );
      final data = res.data!['data'] as List<dynamic>;

      final messages = data
          .map(
            (e) => MessageModel.fromMap(e as Map<String, dynamic>),
          )
          .toList();
      return messages;
    } on NetworkClientException {
      rethrow;
    } on FormatException catch (e, st) {
      throw NetworkClientException(e.message, stackTrace: st);
    }
  }
}
