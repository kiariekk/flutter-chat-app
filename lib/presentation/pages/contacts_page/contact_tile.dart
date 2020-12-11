import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String lastMessageContent;

  const ContactTile({
    Key key,
    @required this.name,
    @required this.lastMessageContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(lastMessageContent),
      ),
    );
  }
}
