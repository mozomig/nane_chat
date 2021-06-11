import 'package:nane_chat/data/model/message_dto.dart';

class MessagesDto {
  List<MessageDto>? result;

  MessagesDto({this.result});

  MessagesDto.fromJson(dynamic json) {
    if (json["result"] != null) {
      result = [];
      json["result"].forEach((v) {
        result?.add(MessageDto.fromJson(v));
      });
    }
  }
}