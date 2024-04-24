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
    on<MessageSent>(_onMessageSent);
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

  Future<void> _onMessageSent(
    MessageSent event,
    Emitter<ConversationListState> emit,
  ) async {
    final messages = state.messagesForConversation(event.conversationId);
    final newMessage = MessageEntity(
      id: 'me',
      text: event.message,
      sentAt: DateTime.now(),
      sender: 'me',
    );

    emit(
      state.copyWith(
        conversations: state.conversations.map((e) {
          if (e.id == event.conversationId) {
            return e.copyWith(messages: [newMessage, ...messages]);
          } else {
            return e;
          }
        }).toList(),
      ),
    );

    await Future<void>.delayed(const Duration(seconds: 2));
    final automatedMessage = MessageEntity(
      id: 'AI',
      text: automatedMessages[state.messagesForConversation(event.conversationId).length % automatedMessages.length],
      sentAt: DateTime.now(),
      sender: 'AI',
    );
    emit(
      state.copyWith(
        conversations: state.conversations.map((e) {
          if (e.id == event.conversationId) {
            return e.copyWith(
              messages: [
                automatedMessage,
                ...state.messagesForConversation(event.conversationId),
              ],
            );
          } else {
            return e;
          }
        }).toList(),
      ),
    );
  }

  final automatedMessages = <String>[
    'Hello there',
    'How are you doing',
    'What are you up to today',
  ];
}
