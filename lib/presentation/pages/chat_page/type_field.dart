import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/entities/chat_route_params.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:flutter_chat_app/presentation/themes/app_colors.dart';
import 'package:provider/provider.dart';

class ChatTypeField extends StatefulWidget {
  const ChatTypeField({
    Key key,
  }) : super(key: key);

  @override
  _ChatTypeFieldState createState() => _ChatTypeFieldState();
}

class _ChatTypeFieldState extends State<ChatTypeField> {
  final _textController = TextEditingController();

  ChatRouteParams chatParams;

  @override
  void initState() {
    super.initState();
    chatParams = Provider.of<ChatRouteParams>(context, listen: false);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(
                left: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                controller: _textController,
                style: TextStyle(color: AppColors.lightColor),
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    final typedValue = _textController.value.text;
    if (typedValue.isEmpty) return;
    _textController.clear();
    final database = getIt<DatabaseService>();
    await database.sendMessage(
      content: typedValue,
      chatReference: chatParams.chatDoc,
      receiverEmail: chatParams.email,
    );
  }
}
