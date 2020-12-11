import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/entities/chat_route_params.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/chat_messages.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/type_field.dart';
import 'package:flutter_chat_app/presentation/widgets/appbar_dropdown_button.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatParams =
        ModalRoute.of(context).settings.arguments as ChatRouteParams;
    return Provider<ChatRouteParams>.value(
      value: chatParams,
      child: Scaffold(
        appBar: AppBar(
          title: Text(chatParams.username),
          actions: [
            AppbarDropdownButton(),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: ChatMessages(),
              ),
            ),
            ChatTypeField(),
          ],
        ),
      ),
    );
  }
}
