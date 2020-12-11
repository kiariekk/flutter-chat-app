import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/entities/add_contact_params.dart';
import 'package:flutter_chat_app/core/exceptions/add_contact_exception.dart';
import 'package:flutter_chat_app/core/models/chat_model.dart';
import 'package:flutter_chat_app/core/models/user_model.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get _users => _firestore.collection('users');

  CollectionReference get chats => _firestore.collection('chats');

  Future<void> initialize() async {
    await _setCurrentUserModel();
  }

  Future<void> _setCurrentUserModel() async {
    final currentUser = AuthService.currentUser;
    final snapshot = await _users.doc(currentUser.uid).get();
    _cachedUserModel = UserModel.fromMap(snapshot.data());
  }

  UserModel get currentUserModel => _cachedUserModel;
  UserModel _cachedUserModel;

  Future<void> addUser({
    @required username,
    @required email,
    @required uid,
  }) async {
    final user = UserModel(email: email, username: username);
    await _users.doc(uid).set(user.toMap());
  }

  Future<void> addChat(AddContactParams params) async {
    final userWithEmail = await findUserWithEmail(params.email);
    if (userWithEmail == null) {
      throw AddContactException(
        "User with email ${params.email} not exists",
      );
    }
    if (userWithEmail.email == AuthService.currentUser.email) {
      throw AddContactException("You can\'t add yourself as a contact");
    }

    final chat = ChatModel.blank(
      user1: ChatModelUser(
        username: currentUserModel.username,
        email: currentUserModel.email,
      ),
      user2: ChatModelUser(
        username: params.username,
        email: params.email,
      ),
    );
    await chats.add(chat.toMap());
  }

  Future<UserModel> findUserWithEmail(String email) async {
    final _querySnapshot = await _users.where('email', isEqualTo: email).get();
    if (_querySnapshot.size > 0) {
      return UserModel.fromMap(_querySnapshot.docs[0].data());
    }
    return null;
  }

  Query get allUserChatsQuery {
    return chats.where('users', arrayContains: {
      "username": currentUserModel.username,
      "email": currentUserModel.email,
    }).orderBy("lastMessage.createdAt", descending: true);
  }
}
