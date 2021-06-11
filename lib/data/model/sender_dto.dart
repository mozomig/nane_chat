import 'package:nane_chat/domain/model/sender.dart';

class SenderDto {
  late String username;

  SenderDto({
    required this.username,
  });

  SenderDto.fromJson(dynamic json) {
    username = json["username"];
  }

  Sender mapToEntity() {
    return Sender(
      username: this.username,
    );
  }
}
