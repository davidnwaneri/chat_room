import 'package:chatroom/chatroom_feature/data/repositories/chat_room_repository.dart';
import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/chatroom_feature/presentations/blocs/conversation_list/conversation_list_bloc.dart';
import 'package:chatroom/chatroom_feature/presentations/view/conversation_screen.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/conversation_widget.dart';
import 'package:chatroom/utils/padding_constants.dart';
import 'package:chatroom/utils/widget_library/widget_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  // ignore: unused_element
  const HomeScreen._({super.key});

  static const routeName = '/home';

  static Route<void> route(RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return BlocProvider<ConversationListBloc>(
          create: (context) => ConversationListBloc(
            repository: context.read<ChatRoomRepository>(),
          ),
          child: FadeTransition(
            opacity: animation,
            child: const HomeScreen._(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        titleSpacing: 0,
        title: Padding(
          padding: leftPadding12,
          child: Text(
            'Chatroom',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: BlocBuilder<ConversationListBloc, ConversationListState>(
        builder: (context, state) {
          return switch (state.status) {
            ConversationListInitial() => const SizedBox(),
            ConversationListLoading() => const _ConversationsLoadingView(),
            ConversationListSuccess() => _ConversationsLoadedView(state.conversations),
            ConversationListFailure(:final message) => _ConversationErrorView(message),
          };
        },
      ),
    );
  }
}

class _ConversationsLoadedView extends StatelessWidget {
  const _ConversationsLoadedView(this.conversations);

  final List<ConversationEntity> conversations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return ConversationWidget(
          conversation: conversation,
          onTap: () {
            Navigator.of(context).pushNamed(
              ConversationScreen.routeName,
              arguments: conversation,
            );
          },
        );
      },
    );
  }
}

class _ConversationsLoadingView extends StatelessWidget {
  const _ConversationsLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
      ),
    );
  }
}

class _ConversationErrorView extends StatelessWidget {
  const _ConversationErrorView(this.message);

  final String message;

  void _fetchConversations(BuildContext context) {
    context.read<ConversationListBloc>().add(const ConversationListFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const Space(5),
          Center(
            child: TextButton(
              onPressed: () => _fetchConversations(context),
              child: const Text('Retry'),
            ),
          ),
        ],
      ),
    );
  }
}
