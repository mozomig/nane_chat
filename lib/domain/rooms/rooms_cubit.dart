import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nane_chat/data/rooms/rooms_repository.dart';
import 'package:nane_chat/domain/model/room.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final RoomsRepository _repository;

  RoomsCubit(this._repository) : super(RoomsInitial());

  Future<void> fetchRooms() async {
    try {
      emit(RoomsLoading());

      final rooms = await _repository.fetchRooms();

      emit(RoomsSuccess(rooms));
    } catch(e) {
      emit(RoomsError());
    }
  }
}
