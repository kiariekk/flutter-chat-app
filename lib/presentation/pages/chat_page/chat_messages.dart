import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_pagination/realtime_pagination.dart';

import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/models/message_model.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';
import 'package:flutter_chat_app/core/models/text_message_model.dart';
import 'package:flutter_chat_app/core/services/database_queries.dart';
import 'package:flutter_chat_app/core/entities/chat_route_params.dart';
import 'package:flutter_chat_app/core/models/location_message_model.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/text_message.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/location_message.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final queries = getIt<DatabaseQueries>();
    final chatParams = Provider.of<ChatRouteParams>(context, listen: false);
    final currentUserEmail = AuthService.currentUser.email;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: RealtimePagination(
        itemsPerPage: 20,
        reverse: true,
        query: queries.allMessagesIn(chatParams.chatDoc),
        emptyDisplay: Container(),
        initialLoading: Container(),
        itemBuilder: (index, context, docSnapshot) {
          final message = MessageModelFactory.createFromMap(docSnapshot.data());
          final sendByCurrentUser = message.senderEmail == currentUserEmail;
          if (message is TextMessageModel) {
            return TextMessage(
              content: message.content,
              sendByCurrentUser: sendByCurrentUser,
            );
          }
          if (message is LocationMessageModel) {
            return LocationMessage(
              coords: message.coords,
              documentRef: docSnapshot.reference,
              sendByCurrentUser: sendByCurrentUser,
            );
          }
          throw UnimplementedError('The message type is not implemented');
        },
      ),
    );
  }
}
