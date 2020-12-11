import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';
import 'package:flutter_chat_app/presentation/pages/add_contact_page/add_contact_screen.dart';
import 'package:flutter_chat_app/presentation/pages/auth_page/auth_screen.dart';
import 'package:flutter_chat_app/presentation/pages/contacts_page/contact_screen.dart';
import 'package:provider/provider.dart';

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
      home: StreamProvider<User>.value(
        value: AuthService.authStateChanges(),
        child: Builder(
          builder: (context) {
            final user = Provider.of<User>(context);
            final isAuthenticated = user != null;
            return isAuthenticated ? ContactScreen() : AuthScreen();
          },
        ),
      ),
      routes: {
        'auth': (_) => AuthScreen(),
        'contacts': (_) => ContactScreen(),
        'add-contact': (_) => AddContact(),
      },
    );
  }
}
