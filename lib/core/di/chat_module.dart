import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nane_chat/core/webscoket/websocket_client.dart';
import 'package:nane_chat/data/chat/chat_repository.dart';
import 'package:nane_chat/data/message_store.dart';
import 'package:nane_chat/data/rooms/rooms_repository.dart';

@module
abstract class ChatModule {
  @singleton
  RoomsRepository provideRepository(Dio dio) {
    return RoomsRepository(dio);
  }

  @singleton
  ChatRepository provideChatRepository(
    Dio dio,
    WebsocketClient websocketClient,
    MessageStore store,
  ) {
    return ChatRepository(dio, websocketClient, store);
  }
}
