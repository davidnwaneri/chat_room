import 'package:chatroom/chatroom_feature/data/repositories/chat_room_repository.dart';
import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/chatroom_feature/domain/entities/message_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  ConversationListBloc({
    required ChatRoomRepository repository,
  })  : _repository = repository,
        super(const ConversationListState()) {
    on<ConversationListFetched>(_onConversationListFetched);
    on<ConversationMessagesFetched>(_onConversationMessagesFetched);
    //
    add(const ConversationListFetched());
  }

  final ChatRoomRepository _repository;

  Future<void> _onConversationListFetched(
    ConversationListFetched event,
    Emitter<ConversationListState> emit,
  ) async {
    emit(state.copyWith(status: const ConversationListLoading()));

    final res = await _repository.getConversations();
    res.fold(
      (l) => emit(
        state.copyWith(
          status: ConversationListFailure(message: l.message),
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: const ConversationListSuccess(),
          conversations: r,
        ),
      ),
    );
  }

  Future<void> _onConversationMessagesFetched(
    ConversationMessagesFetched event,
    Emitter<ConversationListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ConversationListLoading(event.conversationId),
      ),
    );

    final res = await _repository.getMessages(event.conversationId);
    res.fold(
      (l) => emit(
        state.copyWith(
          status: ConversationListFailure(
            message: l.message,
            conversationId: event.conversationId,
          ),
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: const ConversationListSuccess(),
          conversations: state.conversations.map((e) {
            if (e.id == event.conversationId) {
              return e.copyWith(messages: r);
            } else {
              return e;
            }
          }).toList(),
        ),
      ),
    );
  }
}
