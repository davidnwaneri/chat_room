part of 'conversation_list_bloc.dart';

@immutable
final class ConversationListState extends Equatable {
  const ConversationListState({
    this.status = const ConversationListInitial(),
    this.conversations = const [],
  });

  final ConversationListStatus status;
  final List<ConversationEntity> conversations;

  List<MessageEntity> messagesForConversation(String conversationId) {
    final conversation = conversations.firstWhere(
      (e) => e.id == conversationId,
    );

    return conversation.messages ?? [];
  }

  ConversationListState copyWith({
    ConversationListStatus? status,
    List<ConversationEntity>? conversations,
  }) {
    return ConversationListState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
    );
  }

  @override
  List<Object> get props => [status, conversations];
}

@immutable
sealed class ConversationListStatus extends Equatable {
  const ConversationListStatus();

  @override
  List<Object?> get props => [];
}

final class ConversationListInitial extends ConversationListStatus {
  const ConversationListInitial();
}

final class ConversationListLoading extends ConversationListStatus {
  const ConversationListLoading([this.conversationId]);

  /// This is used t represent that the messages for a particular conversation failed.
  ///
  /// If it is not null, then it represents the failed state of the
  /// actual conversation list
  final String? conversationId;

  @override
  List<Object?> get props => [conversationId];
}

final class ConversationListSuccess extends ConversationListStatus {
  const ConversationListSuccess();
}

final class ConversationListFailure extends ConversationListStatus {
  const ConversationListFailure({
    required this.message,
    this.conversationId,
  });

  final String message;

  /// This is used t represent that the messages for a particular conversation is being loaded.
  ///
  /// If it is not null, then it represents the loading state of the
  /// actual conversation list
  final String? conversationId;

  @override
  List<Object?> get props => [message, conversationId];
}
