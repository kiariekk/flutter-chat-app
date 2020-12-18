import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/message.dart';

class LocationMessage extends StatelessWidget {
  final List<double> coords;
  final bool sendByCurrentUser;

  const LocationMessage({
    Key key,
    @required this.coords,
    @required this.sendByCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Message(
      sendByCurrentUser: sendByCurrentUser,
      child: Text(coords.toString()),
    );
  }
}
