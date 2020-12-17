import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final bool sendByCurrentUser;
  final String content;

  const TextMessage({
    Key key,
    @required this.sendByCurrentUser,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: sendByCurrentUser ? 5 : 20,
      ),
      child: Align(
        alignment:
            sendByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
            color: sendByCurrentUser ? Colors.green[500] : Colors.green[700],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
