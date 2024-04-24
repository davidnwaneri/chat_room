import 'package:chatroom/chatroom_feature/data/repositories/chat_room_repository.dart';
import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';

class ConversationListBloc extends Bloc<ConversationListFetched, ConversationListState> {
  ConversationListBloc({
    required ChatRoomRepository repository,
  })  : _repository = repository,
        super(const ConversationListState()) {
    on<ConversationListFetched>((event, emit) async {
      emit(state.copyWith(status: const ConversationListLoading()));

      final res = await _repository.getConversations();
      res.fold(
        (l) => emit(state.copyWith(status: ConversationListFailure(l.message))),
        (r) => emit(
          state.copyWith(
            status: const ConversationListSuccess(),
            conversations: r,
          ),
        ),
      );
    });
    //
    add(const ConversationListFetched());
  }

  final ChatRoomRepository _repository;
}
