import 'package:nane_chat/data/model/room_dto.dart';

class RoomsDto {
  List<RoomDto>? result;

  RoomsDto({this.result});

  RoomsDto.fromJson(dynamic json) {
    if (json["result"] != null) {
      result = [];
      json["result"].forEach((v) {
        result?.add(RoomDto.fromJson(v));
      });
    }
  }
}