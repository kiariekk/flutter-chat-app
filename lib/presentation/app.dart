import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';
import 'package:flutter_chat_app/presentation/pages/auth_page/auth_screen.dart';
import 'package:flutter_chat_app/presentation/pages/contacts_page/contact_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.orange,
      ),
      home: StreamBuilder(
        stream: AuthService.authStateChanges(),
        builder: (context, snapshot) {
          final isAuthenticated = snapshot.hasData;
          return isAuthenticated ? ContactScreen() : AuthScreen();
        },
      ),
    );
  }
}
