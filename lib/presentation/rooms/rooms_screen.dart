import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nane_chat/core/di/app_config.dart';
import 'package:nane_chat/data/rooms/rooms_repository.dart';
import 'package:nane_chat/domain/model/room.dart';
import 'package:nane_chat/domain/rooms/rooms_cubit.dart';
import 'package:nane_chat/presentation/chat/chat_screen.dart';
import 'package:nane_chat/presentation/widgets/retry_widget.dart';
import 'package:nane_chat/presentation/widgets/room_widget.dart';

class RoomsScreen extends StatefulWidget {
  RoomsScreen._({Key? key}) : super(key: key);

  static Widget newInstance({Key? key}) {
    return BlocProvider(
      create: (_) => RoomsCubit(
        getIt.get<RoomsRepository>(),
      ),
      child: RoomsScreen._(
        key: key,
      ),
    );
  }

  @override
  _RoomsScreenState createState() {
    return _RoomsScreenState();
  }
}

class _RoomsScreenState extends State<RoomsScreen> {
  RoomsCubit get _cubit => BlocProvider.of(context);

  @override
  void initState() {
    _cubit.fetchRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rooms"),
      ),
      body: BlocBuilder<RoomsCubit, RoomsState>(
        builder: (context, state) {
          return _render(state);
        },
      ),
    );
  }

  Widget _render(RoomsState state) {
    if (state is RoomsError) {
      return _onError("ff");
    }

    if (state is RoomsSuccess) {
      return _onSuccess(state.rooms);
    }

    return _onLoading();
  }

  Widget _onError(String msg) {
    return RetryWidget(
      msg: msg,
      retry: () {
        _cubit.fetchRooms();
      },
    );
  }

  Widget _onLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _onSuccess(List<Room> rooms) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.grey[300],
        );
      },
      itemCount: rooms.length,
      padding: EdgeInsets.only(
        bottom: 20 + MediaQuery.of(context).padding.bottom,
      ),
      itemBuilder: (context, index) {
        final room = rooms[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen.newInstance(room: room.name, profileCubit: BlocProvider.of(context)),
              ),
            );
          },
          child: RoomWidget(
            name: room.name,
            created: room.lastMessage.created,
            sender: room.lastMessage.sender.username,
            lastMessage: room.lastMessage.room,
          ),
        );
      },
    );
  }
}
