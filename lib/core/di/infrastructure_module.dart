import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nane_chat/core/webscoket/websocket_client.dart';
import 'package:nane_chat/data/message_store.dart';

@module
abstract class InfrastructureModule {
  @singleton
  Dio provideHttpClient() {
    return Dio(
      BaseOptions(
        baseUrl: "https://nane.tada.team",
        contentType: "application/json",
      ),
    );
  }

  @singleton
  WebsocketClient provideWebsocketClient() {
    return WebsocketClient();
  }

  @singleton
  MessageStore provideMessageStore() {
    return MessageStore();
  }
}
