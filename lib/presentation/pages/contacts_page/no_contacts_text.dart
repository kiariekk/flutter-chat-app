import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/primary_button.dart';

class NoContactsText extends StatelessWidget {
  const NoContactsText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No contacts yet ☹️',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          PrimaryButton(
            text: 'Start adding some',
            onPressed: () => Navigator.of(context).pushNamed('add-contact'),
          ),
        ],
      ),
    );
  }
}
