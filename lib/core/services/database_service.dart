import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/entities/add_contact_params.dart';
import 'package:flutter_chat_app/core/exceptions/add_contact_exception.dart';
import 'package:flutter_chat_app/core/models/contact_model.dart';
import 'package:flutter_chat_app/core/models/user_model.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';

class DatabaseService {
  DatabaseService._();

  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference get _users => _firestore.collection('users');

  static DocumentReference get _currentUserDoc =>
      _users.doc(AuthService.currentUser.uid);

  static CollectionReference get contacts =>
      _currentUserDoc.collection('contacts');

  static Future<void> addUser({
    @required username,
    @required email,
    @required uid,
  }) async {
    final user = UserModel(email: email, username: username);
    await _users.doc(uid).set(user.toMap());
  }

  static Future<void> addContact(AddContactParams params) async {
    final userWithEmail = await findUserWithEmail(params.email);
    if (userWithEmail == null) {
      throw AddContactException(
        "User with email ${params.email} not exists",
      );
    }
    if (userWithEmail.email == AuthService.currentUser.email) {
      throw AddContactException("You can\'t add yourself as a contact");
    }

    final contact = ContactModel.blank(name: params.name, email: params.email);
    await contacts.add(contact.toMap());
  }

  static Future<UserModel> findUserWithEmail(String email) async {
    final _querySnapshot = await _users.where('email', isEqualTo: email).get();
    if (_querySnapshot.size > 0) {
      return UserModel.fromMap(_querySnapshot.docs[0].data());
    }
    return null;
  }
}
