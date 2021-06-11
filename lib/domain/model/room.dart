import 'package:nane_chat/domain/model/sender.dart';

import 'message.dart';

class Room {
  final String name;
  final Message lastMessage;

  Room({
    required this.name,
    required this.lastMessage,
  });
}
