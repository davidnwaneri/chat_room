import 'package:chatroom/app/app.dart';
import 'package:chatroom/chatroom_feature/data/datasources/chat_room_remote_data_source.dart';
import 'package:chatroom/chatroom_feature/data/repositories/chat_room_repository.dart';
import 'package:chatroom/chatroom_feature/presentations/blocs/conversation_list/conversation_list_bloc.dart';
import 'package:chatroom/core/network/network_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  _addFontsLicense();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>(
          create: (context) => Dio(),
        ),
        RepositoryProvider<NetworkClient>(
          create: (context) => NetworkClient(
            dio: context.read<Dio>(),
          ),
        ),
        RepositoryProvider<ChatRoomRemoteDataSource>(
          create: (context) => ChatRoomRemoteDataSource(
            networkClient: context.read<NetworkClient>(),
          ),
        ),
        RepositoryProvider<ChatRoomRepository>(
          create: (context) => ChatRoomRepository(
            remoteDataSource: context.read<ChatRoomRemoteDataSource>(),
          ),
        ),
      ],
      child: BlocProvider<ConversationListBloc>(
        create: (context) => ConversationListBloc(
          repository: context.read<ChatRoomRepository>(),
        ),
        child: const ChatRoomApp(),
      ),
    ),
  );
}

void _addFontsLicense() {
  // Disable HTTP fetching of fonts at runtime
  GoogleFonts.config.allowRuntimeFetching = false;

  LicenseRegistry.addLicense(() async* {
    final inconsolataFontLicense = await rootBundle.loadString('assets/fonts/google_fonts/inconsolata/OFL.txt');

    yield LicenseEntryWithLineBreaks(['google_fonts'], inconsolataFontLicense);
  });
}
