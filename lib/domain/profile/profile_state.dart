part of 'profile_cubit.dart';

class ProfileState {
  final String? username;

  ProfileState(this.username);

  ProfileState copyWith({
    String? username,
  }) {
    return ProfileState(username ?? this.username);
  }
}
