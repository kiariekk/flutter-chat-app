import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/appbar_dropdown_button.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        titleSpacing: 30,
        actions: [
          AppbarDropdownButton(),
        ],
      ),
      body: Container(),
    );
  }
}
