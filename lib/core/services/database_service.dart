import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/models/user.dart';

class DatabaseService {
  DatabaseService._();

  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference get _users => _firestore.collection('users');

  static Future<void> addUser({
    @required username,
    @required email,
    @required uid,
  }) async {
    final user = User(email: email, username: username);
    await _users.doc(uid).set(user.toMap());
  }
}
