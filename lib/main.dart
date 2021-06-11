import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nane_chat/domain/profile/profile_cubit.dart';
import 'package:nane_chat/presentation/auth/entry_screen.dart';
import 'package:nane_chat/presentation/rooms/rooms_screen.dart';

import 'core/di/app_config.dart';

void main() {
  configureDependencies();
  runApp(
    BlocProvider(
      create: (_) => ProfileCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaneChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EntryScreen.newInstance(
        profileCubit: BlocProvider.of(context),
      ),
    );
  }
}
