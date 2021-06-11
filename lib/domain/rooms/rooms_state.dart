part of 'rooms_cubit.dart';

@immutable
abstract class RoomsState {}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsError extends RoomsState {}

class RoomsSuccess extends RoomsState {
  final List<Room> rooms;

  RoomsSuccess(this.rooms);
}
