part of 'conversation_list_bloc.dart';

@immutable
abstract class ConversationListEvent extends Equatable {
  const ConversationListEvent();

  @override
  List<Object> get props => [];
}

final class ConversationListFetched extends ConversationListEvent {
  const ConversationListFetched();

  @override
  List<Object> get props => [];
}

final class ConversationMessagesFetched extends ConversationListEvent {
  const ConversationMessagesFetched(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}

final class MessageSent extends ConversationListEvent {
  const MessageSent({
    required this.conversationId,
    required this.message,
  });

  final String conversationId;
  final String message;

  @override
  List<Object> get props => [conversationId];
}
