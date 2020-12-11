import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/models/contact_model.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:flutter_chat_app/plugins/realtime_pagination/realtime_pagination.dart';
import 'package:flutter_chat_app/presentation/pages/contacts_page/contact_tile.dart';
import 'package:flutter_chat_app/presentation/widgets/no_glow_scroll_behavior.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: RealtimePagination(
        query: DatabaseService.contacts
            .orderBy("lastMessage.createdAt", descending: true),
        itemsPerPage: 12,
        scrollThreshold: 0.8,
        listViewCacheExtent: 3000,
        itemBuilder: (index, context, docSnapshot) {
          final contact = ContactModel.fromMap(docSnapshot.data());
          return ContactTile(
            name: contact.name,
            lastMessageContent: contact.lastMessage.content,
          );
        },
      ),
    );
  }
}
