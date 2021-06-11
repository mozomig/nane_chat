import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:nane_chat/data/chat/chat_repository.dart';
import 'package:nane_chat/domain/auth/model/username_field.dart';
import 'package:nane_chat/domain/profile/profile_cubit.dart';

part 'entry_state.dart';

class EntryCubit extends Cubit<EntryState> {
  ChatRepository _repository;
  ProfileCubit _profileCubit;

  EntryCubit(this._repository, this._profileCubit)
      : super(
          EntryState(
            status: Status.idle,
            username: UsernameField(),
          ),
        );

  void setUsername(String username) {
    emit(
      state.copyWith(
        username: state.username.copyWith(value: username).validate(),
      ),
    );
  }

  void submit() {
    if (state.username.valid()) {
      _profileCubit.setUsername(state.username.value);

      try {
        emit(
          state.copyWith(
            status: Status.loading,
          ),
        );
        
        _repository.connect(state.username.value);

        emit(
          state.copyWith(
            status: Status.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: Status.error,
          ),
        );
      }
    }
  }
}
