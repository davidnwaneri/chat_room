import 'package:chatroom/chatroom_feature/domain/entities/conversation_entity.dart';
import 'package:chatroom/chatroom_feature/presentations/blocs/conversation_list/conversation_list_bloc.dart';
import 'package:chatroom/chatroom_feature/presentations/view/conversation_screen.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/conversation_widget.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/error_view.dart';
import 'package:chatroom/chatroom_feature/presentations/widgets/loading_view.dart';
import 'package:chatroom/utils/padding_constants.dart';
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
        return FadeTransition(
          opacity: animation,
          child: const HomeScreen._(),
        );
      },
    );
  }

  void _fetchConversations(BuildContext context) {
    context.read<ConversationListBloc>().add(const ConversationListFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
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
            ConversationListLoading(:final conversationId) => (conversationId == null) //
                ? const LoadingView() //
                : _ConversationsLoadedView(state.conversations),
            ConversationListSuccess() => _ConversationsLoadedView(state.conversations),
            ConversationListFailure(:final message, :final conversationId) => (conversationId == null)
                ? ErrorView(
                    message: message,
                    onRetry: () => _fetchConversations(context),
                  )
                : _ConversationsLoadedView(state.conversations),
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
            final hasFetchedMessages = context //
                    .read<ConversationListBloc>() //
                    .state //
                    .conversations //
                    .firstWhere((e) => e.id == conversation.id) //
                    .messages !=
                null;
            if (hasFetchedMessages == false) {
              context.read<ConversationListBloc>().add(ConversationMessagesFetched(conversation.id));
            }

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
