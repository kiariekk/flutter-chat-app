import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/app_bar_dropdown_button.dart';
import 'package:flutter_chat_app/presentation/pages/contacts_page/contact_list.dart';
import 'package:flutter_chat_app/presentation/themes/app_colors.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        titleSpacing: 30,
        actions: [
          AppBarDropdownButton(),
        ],
      ),
      body: ContactList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: AppColors.lightColor,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('add-contact');
        },
      ),
    );
  }
}
