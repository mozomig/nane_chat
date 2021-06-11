import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void OnClick();

class PrimaryButton extends StatefulWidget {
  final String text;
  final OnClick onClick;
  final bool isEnabled;
  final bool isLoading;

  PrimaryButton({
    required this.text,
    required this.onClick,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  State<StatefulWidget> createState() => PrimaryButtonState();
}

class PrimaryButtonState extends State<PrimaryButton> {

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        decoration: BoxDecoration(
          color: widget.isLoading || !widget.isEnabled
              ? Colors.grey
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            if (!widget.isLoading) {
              widget.onClick();
            }
          },
          child: Center(
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.isLoading
                          ? Colors.transparent
                          : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
