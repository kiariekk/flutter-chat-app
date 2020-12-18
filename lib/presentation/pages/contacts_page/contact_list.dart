import 'package:flutter/material.dart';
import 'package:realtime_pagination/realtime_pagination.dart';

import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/models/chat_model.dart';
import 'package:flutter_chat_app/core/services/database_queries.dart';
import 'package:flutter_chat_app/presentation/pages/contacts_page/contact_tile.dart';
import 'package:flutter_chat_app/presentation/widgets/no_glow_scroll_behavior.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final queries = getIt<DatabaseQueries>();
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: RealtimePagination(
        query: queries.allChatsOfCurrentUser,
        itemsPerPage: 12,
        scrollThreshold: 0.8,
        listViewCacheExtent: 3000,
        itemBuilder: (index, context, docSnapshot) {
          final chat = ChatModel.fromMap(docSnapshot.data());
          return ContactTile(
            chatDoc: docSnapshot.reference,
            chatModelUser: chat.otherUser,
            lastMessageContent: chat.lastMessage.content,
          );
        },
      ),
    );
  }
}
