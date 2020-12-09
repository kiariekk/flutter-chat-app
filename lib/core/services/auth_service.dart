import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';

class AuthService {
  AuthService._();

  static final _firebaseAuth = FirebaseAuth.instance;

  static Future<void> signUp({
    @required String password,
    @required String username,
    @required String email,
  }) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await DatabaseService.addUser(
      username: username,
      email: email,
      uid: credentials.user.uid,
    );
  }

  static Future<void> signIn({
    @required String password,
    @required String email,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
