import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

typedef void EventCallback(Map<String, dynamic> data);

class WebsocketClient {
  late final WebSocketChannel _channel;
  final List<EventCallback> _subcriptions = [];

  void connect(String username) {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://nane.tada.team/ws?username=$username'),
    );

    _channel.stream.listen((event) {
      _subcriptions.forEach((element) {
        element(json.decode(event));
      });

      print("WS: $event");
    }, onDone: () {
      print("WS on done ${_channel.closeReason}");
    }, onError: (err) {
      print("WS on error: $err");
    });
  }

  void send(Map<String, dynamic> data) {
    print(data);
    _channel.sink.add(json.encode(data));
  }

  void listenEvent(EventCallback sub) {
    _subcriptions.add(sub);
  }

  void unlistenEvent(EventCallback sub) {
    _subcriptions.remove(sub);
  }

  void close() {
    _channel.sink.close();
    _subcriptions.clear();
  }
}
