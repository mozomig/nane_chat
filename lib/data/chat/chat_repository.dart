import 'dart:async';

import 'package:dio/dio.dart';
import 'package:nane_chat/core/webscoket/websocket_client.dart';
import 'package:nane_chat/data/message_store.dart';
import 'package:nane_chat/data/model/message_dto.dart';
import 'package:nane_chat/domain/model/message.dart';
import 'package:nane_chat/domain/model/sender.dart';
import 'package:uuid/uuid.dart';

import 'model/messages_dto.dart';

typedef void MessageUpdated(List<Message> messages);

class ChatRepository {
  Uuid uuid = Uuid();
  Dio _dio;
  WebsocketClient _wsClient;
  MessageStore _store;

  Map<String, MessageUpdated> _messages = Map();

  ChatRepository(this._dio, this._wsClient, this._store);

  void listenMessage(String room, MessageUpdated callback) {
    _messages[room] = callback;
  }

  void unlistenMessage(String room) {
    _messages.remove(room);
  }

  void connect(String username) {
    _wsClient.listenEvent(_incomingEvent);
    _wsClient.connect(username);
  }

  void sendMessage({
    required String username,
    required String room,
    required String text,
  }) {
    final tempMsg = Message(
      id: uuid.v4(),
      room: room,
      text: text,
      created: DateTime.now(),
      sender: Sender(
        username: username,
      ),
    );

    _store.save(room, tempMsg);
    _messages[room]?.call(_store.getMessage(room));

    _wsClient.send(
      {
        "room": tempMsg.room,
        "text": tempMsg.text,
        "id": tempMsg.id,
      },
    );
  }

  Future<void> getHistory(String room) async {
    final response = await _dio.get("/api/rooms/$room/history");
    final messages = MessagesDto.fromJson(response.data)
            .result
            ?.map(
              (e) => e.mapToEntity(),
            )
            .toList() ??
        [];

    _store.saveAll(room, messages);
    _messages[room]?.call(_store.getMessage(room));
  }

  void close() {
    _wsClient.unlistenEvent(_incomingEvent);
    _wsClient.close();
  }

  void _incomingEvent(Map<String, dynamic> event) {
    if (event["room"] != null &&
        event["text"] != null &&
        event["created"] != null &&
        event["sender"] != null) {
      final message = MessageDto.fromJson(event).mapToEntity();

      if (message.id != null) {
        _store.removeById(room: message.room, id: message.id!);
      }

      _store.save(message.room, message);

      _messages[message.room]?.call(_store.getMessage(message.room));
    }
  }
}
