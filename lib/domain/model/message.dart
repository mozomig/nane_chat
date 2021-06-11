import 'package:equatable/equatable.dart';
import 'package:nane_chat/domain/model/sender.dart';

class Message extends Equatable {
  final String? id;
  final String room;
  final String text;
  final DateTime created;
  final Sender sender;

  Message({
    this.id,
    required this.room,
    required this.text,
    required this.created,
    required this.sender,
  });

  @override
  List<Object?> get props => [
        id,
        room,
        text,
        created,
        sender,
      ];
}
