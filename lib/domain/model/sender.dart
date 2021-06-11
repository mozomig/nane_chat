import 'package:equatable/equatable.dart';

class Sender extends Equatable {
  final String username;

  Sender({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}
