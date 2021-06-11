import 'package:nane_chat/data/model/sender_dto.dart';
import 'package:nane_chat/data/rooms/model/rooms_dto.dart';
import 'package:nane_chat/domain/model/message.dart';

class MessageDto {
  String? id;
  late String room;
  late String created;
  late SenderDto sender;
  late String text;

  MessageDto({
    this.id,
    required this.room,
    required this.created,
    required this.sender,
    required this.text,
  });

  MessageDto.fromJson(dynamic json) {
    room = json["room"];
    id = json["id"];
    created = json["created"];
    sender = SenderDto.fromJson(json["sender"]);
    text = json["text"];
  }

  Message mapToEntity() {
    return Message(
      id: this.id,
      room: this.room,
      created: DateTime.parse(this.created),
      text: this.text,
      sender: this.sender.mapToEntity(),
    );
  }
}
