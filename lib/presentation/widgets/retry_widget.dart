import 'package:flutter/material.dart';

typedef void RetryCallback();

class RetryWidget extends StatelessWidget {
  final String msg;
  final RetryCallback retry;

  RetryWidget({
    Key? key,
    required this.msg,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(msg),
        SizedBox(
          height: 12,
        ),
        TextButton(
          onPressed: () {
            retry();
          },
          child: Text(
            "Retry",
          ),
        ),
      ],
    );
  }
}
