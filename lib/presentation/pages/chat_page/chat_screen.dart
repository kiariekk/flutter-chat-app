import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/entities/chat_route_params.dart';
import 'package:flutter_chat_app/core/entities/send_location_params.dart';
import 'package:flutter_chat_app/core/usecases/send_location_message.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/chat_messages.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/type_field.dart';
import 'package:flutter_chat_app/presentation/widgets/app_bar_dropdown_button.dart';
import 'package:flutter_chat_app/presentation/widgets/appbar_dropdown_menu_item.dart';
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
            AppBarDropdownButton(
              additionalItems: [
                AppBarDropdownMenuItem(
                  icon: Icon(
                    Icons.location_on,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _sendLocationButtonHandle(chatParams),
                  title: Text(
                    'Send location',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  value: 'Send location',
                ),
              ],
            ),
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

  void _sendLocationButtonHandle(ChatRouteParams chatParams) {
    final sendLocation = getIt<SendLocation>();
    sendLocation.call(SendLocationParams(
      chatDoc: chatParams.chatDoc,
      receiverEmail: chatParams.email,
    ));
  }
}
