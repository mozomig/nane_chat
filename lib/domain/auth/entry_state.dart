part of 'entry_cubit.dart';

enum Status {
  idle,
  loading,
  error,
  success,
}

class EntryState {
  final Status status;
  final UsernameField username;

  EntryState({
    required this.status,
    required this.username,
  });

  EntryState copyWith({
    Status? status,
    UsernameField? username,
  }) {
    return EntryState(
      status: status ?? this.status,
      username: username ?? this.username,
    );
  }
}
