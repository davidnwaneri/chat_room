part of 'conversation_list_bloc.dart';

@immutable
final class ConversationListState extends Equatable {
  const ConversationListState({
    this.status = const ConversationListInitial(),
    this.conversations = const [],
  });

  final ConversationListStatus status;
  final List<ConversationEntity> conversations;

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
  List<Object> get props => [];
}

final class ConversationListInitial extends ConversationListStatus {
  const ConversationListInitial();
}

final class ConversationListLoading extends ConversationListStatus {
  const ConversationListLoading();
}

final class ConversationListSuccess extends ConversationListStatus {
  const ConversationListSuccess();
}

final class ConversationListFailure extends ConversationListStatus {
  const ConversationListFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
