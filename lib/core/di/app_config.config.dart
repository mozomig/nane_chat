// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/chat/chat_repository.dart' as _i7;
import '../../data/message_store.dart' as _i4;
import '../../data/rooms/rooms_repository.dart' as _i5;
import '../webscoket/websocket_client.dart' as _i6;
import 'chat_module.dart' as _i9;
import 'infrastructure_module.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final infrastructureModule = _$InfrastructureModule();
  final chatModule = _$ChatModule();
  gh.singleton<_i3.Dio>(infrastructureModule.provideHttpClient());
  gh.singleton<_i4.MessageStore>(infrastructureModule.provideMessageStore());
  gh.singleton<_i5.RoomsRepository>(
      chatModule.provideRepository(get<_i3.Dio>()));
  gh.singleton<_i6.WebsocketClient>(
      infrastructureModule.provideWebsocketClient());
  gh.singleton<_i7.ChatRepository>(chatModule.provideChatRepository(
      get<_i3.Dio>(), get<_i6.WebsocketClient>(), get<_i4.MessageStore>()));
  return get;
}

class _$InfrastructureModule extends _i8.InfrastructureModule {}

class _$ChatModule extends _i9.ChatModule {}
