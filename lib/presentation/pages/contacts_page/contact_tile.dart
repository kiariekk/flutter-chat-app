import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/entities/chat_route_params.dart';
import 'package:flutter_chat_app/core/models/chat_model.dart';

class ContactTile extends StatelessWidget {
  final ChatModelUser chatModelUser;
  final String lastMessageContent;
  final DocumentReference chatDoc;

  const ContactTile({
    Key key,
    @required this.lastMessageContent,
    @required this.chatModelUser,
    @required this.chatDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _enterInChat(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          ),
        ),
        child: ListTile(
          title: Text(chatModelUser.username),
          subtitle: Text(lastMessageContent),
        ),
      ),
    );
  }

  void _enterInChat(BuildContext context) {
    Navigator.of(context).pushNamed(
      'chat',
      arguments: ChatRouteParams(
        chatDoc: chatDoc,
        username: chatModelUser.username,
        email: chatModelUser.email,
      ),
    );
  }
}
