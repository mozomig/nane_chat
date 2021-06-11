import 'package:nane_chat/data/model/sender_dto.dart';
import 'package:nane_chat/domain/model/room.dart';

import 'message_dto.dart';

class RoomDto {
  late String name;
  late MessageDto lastMessage;
  late SenderDto senderDto;

  RoomDto({
    required this.name,
    required this.lastMessage,
    required this.senderDto,
  });

  RoomDto.fromJson(dynamic json) {
    name = json["name"];
    lastMessage = MessageDto.fromJson(json["last_message"]);
  }

  Room mapToEntity() {
    return Room(
      name: this.name,
      lastMessage: this.lastMessage.mapToEntity(),
    );
  }
}
