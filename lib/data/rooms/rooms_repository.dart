import 'package:dio/dio.dart';
import 'package:nane_chat/data/rooms/model/rooms_dto.dart';
import 'package:nane_chat/domain/model/room.dart';

class RoomsRepository {
  Dio _dio;

  RoomsRepository(this._dio);

  Future<List<Room>> fetchRooms() async {
    final response = await _dio.get("/api/rooms");
    return RoomsDto.fromJson(response.data)
            .result
            ?.map(
              (e) => e.mapToEntity(),
            )
            .toList() ??
        [];
  }


}
