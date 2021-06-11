import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nane_chat/core/di/app_config.dart';
import 'package:nane_chat/domain/auth/entry_cubit.dart';
import 'package:nane_chat/domain/profile/profile_cubit.dart';
import 'package:nane_chat/presentation/rooms/rooms_screen.dart';
import 'package:nane_chat/presentation/widgets/primary_button.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen._({Key? key}) : super(key: key);

  static Widget newInstance({
    Key? key,
    required ProfileCubit profileCubit,
  }) {
    return BlocProvider(
      create: (_) => EntryCubit(getIt.get(), profileCubit),
      child: EntryScreen._(
        key: key,
      ),
    );
  }

  @override
  _EntryScreenState createState() {
    return _EntryScreenState();
  }
}

class _EntryScreenState extends State<EntryScreen> {
  EntryCubit get _cubit => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entry"),
      ),
      body: BlocConsumer<EntryCubit, EntryState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => RoomsScreen.newInstance(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (text) {
                    _cubit.setUsername(text);
                  },
                  decoration: InputDecoration(hintText: "Name"),
                ),
                SizedBox(
                  height: 12,
                ),
                PrimaryButton(
                  text: "Entry",
                  onClick: () {
                    _cubit.submit();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
