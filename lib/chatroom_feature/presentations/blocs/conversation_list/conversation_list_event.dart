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
