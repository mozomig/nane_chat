import 'dart:collection';

import 'package:nane_chat/domain/model/message.dart';

class MessageStore {
  Map<String, LinkedHashSet<Message>> _store = Map();

  List<Message> getMessage(String room) {
    return _store[room]?.toList() ?? [];
  }

  void save(String room, Message message) {
    final messages = _store[room] ?? LinkedHashSet();
    messages.add(message);
    _store[room] = messages;
  }

  void saveAll(String room, List<Message> message) {
    final messages = _store[room] ?? LinkedHashSet();
    messages.addAll(message);
    _store[room] = messages;
  }

  void removeById({
    required String room,
    required String id,
  }) {
    final messages = _store[room] ?? LinkedHashSet();
    messages.removeWhere((element) => element.id == id);
  }
}
