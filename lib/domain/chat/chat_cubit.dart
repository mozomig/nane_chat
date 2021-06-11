import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nane_chat/data/chat/chat_repository.dart';
import 'package:nane_chat/domain/model/message.dart';
import 'package:nane_chat/domain/profile/profile_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;
  final ProfileCubit _profileCubit;
  final String _room;

  ChatCubit(this._repository, this._room, this._profileCubit)
      : super(ChatInitial()) {
    _repository.listenMessage(_room, _messageUpdate);
  }

  Future<void> getHistory() async {
    try {
      emit(ChatLoading());
      await _repository.getHistory(_room);
    } catch (e) {
      emit(ChatError());
    }
  }

  void sendMessage(String text) async {
    _repository.sendMessage(
      username: _profileCubit.state.username!,
      room: _room,
      text: text,
    );
  }

  void _messageUpdate(List<Message> messages) {
    emit(ChatSuccess(messages));
  }

  @override
  Future<void> close() {
    _repository.unlistenMessage(_room);
    return super.close();
  }
}
