import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:flutter_chat_app/presentation/pages/add_contact_page/add_contact_screen.dart';
import 'package:flutter_chat_app/presentation/pages/auth_page/auth_screen.dart';
import 'package:flutter_chat_app/presentation/pages/chat_page/chat_screen.dart';
import 'package:flutter_chat_app/presentation/pages/contacts_page/contact_screen.dart';
import 'package:flutter_chat_app/presentation/widgets/loading_screen.dart';

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
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final isAuthenticated = snapshot.hasData;
          if (isAuthenticated) {
            return FutureBuilder(
              future: getIt<DatabaseService>().updateCurrentUserModel(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ContactScreen();
                }
                return LoadingScreen();
              },
            );
          }
          return AuthScreen();
        },
      ),
      routes: {
        'auth': (_) => AuthScreen(),
        'contacts': (_) => ContactScreen(),
        'add-contact': (_) => AddContact(),
        'chat': (_) => ChatScreen(),
      },
    );
  }
}
