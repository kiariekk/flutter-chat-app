import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/models/chat_model.dart';
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
    final database = getIt<DatabaseService>();
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: RealtimePagination(
        query: database.allUserChatsQuery,
        itemsPerPage: 12,
        scrollThreshold: 0.8,
        listViewCacheExtent: 3000,
        itemBuilder: (index, context, docSnapshot) {
          final chat = ChatModel.fromMap(docSnapshot.data());
          return ContactTile(
            name: chat.otherUser.username,
            lastMessageContent: chat.lastMessage.content,
          );
        },
      ),
    );
  }
}
