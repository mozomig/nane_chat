import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nane_chat/core/di/app_config.dart';
import 'package:nane_chat/domain/chat/chat_cubit.dart';
import 'package:nane_chat/domain/model/message.dart';
import 'package:nane_chat/domain/profile/profile_cubit.dart';
import 'package:nane_chat/presentation/widgets/message_widget.dart';
import 'package:nane_chat/presentation/widgets/retry_widget.dart';

class ChatScreen extends StatefulWidget {
  final String room;

  ChatScreen._({
    Key? key,
    required this.room,
  }) : super(key: key);

  static Widget newInstance({
    Key? key,
    required String room,
    required ProfileCubit profileCubit,
  }) {
    return BlocProvider(
      create: (_) => ChatCubit(
        getIt.get(),
        room,
        profileCubit,
      ),
      child: ChatScreen._(
        room: room,
      ),
    );
  }

  @override
  _ChatScreenState createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  ChatCubit get _cubit => BlocProvider.of(context);

  ProfileCubit get _profileCubit => BlocProvider.of(context);
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    _cubit.getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return _render(state);
        },
      ),
    );
  }

  Widget _render(ChatState state) {
    if (state is ChatError) {
      return _onError("ff");
    }

    if (state is ChatSuccess) {
      return _onSuccess(
          state.messages..sort((a, b) => b.created.compareTo(a.created)));
    }

    return _onLoading();
  }

  Widget _onError(String msg) {
    return RetryWidget(
      msg: msg,
      retry: () {
        _cubit.getHistory();
      },
    );
  }

  Widget _onLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _onSuccess(List<Message> messages) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12,
              );
            },
            reverse: true,
            itemCount: messages.length,
            padding: EdgeInsets.only(
              bottom: 8,
              left: 16,
              right: 16,
            ),
            itemBuilder: (context, index) {
              final message = messages[index];
              return InkWell(
                onTap: () {},
                child: MessageWidget(
                  text: message.text,
                  sender: message.sender.username,
                  created: message.created,
                  align: _profileCubit.state.username == message.sender.username
                      ? BubbleAlign.RIGHT
                      : BubbleAlign.LEFT,
                ),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 12,
            right: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration.collapsed(
                    hintText: "Message...",
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    _cubit.sendMessage(_messageController.text);
                    _messageController.clear();
                  }
                },
                icon: Icon(Icons.send),
              ),
            ],
          ),
        )
      ],
    );
  }
}
