import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/message.dart';

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
    return Message(
      sendByCurrentUser: sendByCurrentUser,
      child: Text(
        content,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
