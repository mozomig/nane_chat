import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  final String name;
  final DateTime created;
  final String sender;
  final String lastMessage;

  RoomWidget({
    Key? key,
    required this.name,
    required this.created,
    required this.sender,
    required this.lastMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  sender,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  lastMessage,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
