import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/pages/auth_page/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(),
    );
  }
}
