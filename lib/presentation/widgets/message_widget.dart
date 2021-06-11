import 'package:flutter/material.dart';

enum BubbleAlign {
  LEFT,
  RIGHT,
}

class MessageWidget extends StatelessWidget {
  final String text;
  final String sender;
  final DateTime created;
  final BubbleAlign align;

  MessageWidget({
    Key? key,
    required this.text,
    required this.sender,
    required this.created,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: align == BubbleAlign.LEFT
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color:
                    align == BubbleAlign.LEFT ? Colors.grey[300] : Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: BoxConstraints(
                minWidth: 56,
                maxWidth: constraints.maxWidth * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: align == BubbleAlign.LEFT
                              ? Colors.black
                              : Colors.white,
                        ),
                  ),
                  Text(text, style: Theme.of(context).textTheme.caption!.copyWith(
                    color: align == BubbleAlign.LEFT
                        ? Colors.black
                        : Colors.white,
                  ),),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
