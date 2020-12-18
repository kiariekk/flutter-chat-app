import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/entities/add_contact_params.dart';
import 'package:flutter_chat_app/core/exceptions/add_contact_exception.dart';
import 'package:flutter_chat_app/core/models/chat_model.dart';
import 'package:flutter_chat_app/core/models/location_message_model.dart';
import 'package:flutter_chat_app/core/models/message_model.dart';
import 'package:flutter_chat_app/core/models/text_message_model.dart';
import 'package:flutter_chat_app/core/models/user_model.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';
import 'package:flutter_chat_app/core/services/database_queries.dart';

class DatabaseService {
  DatabaseService.singleton();

  DatabaseQueries get _queries => getIt<DatabaseQueries>();

  Future<void> initialize() async {
    await updateCurrentUserModel();
  }

  Future<void> updateCurrentUserModel() async {
    final currentUser = AuthService.currentUser;
    final snapshot = await _queries.users.doc(currentUser.uid).get();
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
    await _queries.users.doc(uid).set(user.toMap());
  }

  Future<void> addChat(AddContactParams params) async {
    final userWithEmail = await _findUserWithEmail(params.email);
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
    await _queries.chats.add(chat.toMap());
  }

  Future<UserModel> _findUserWithEmail(String email) async {
    final _querySnapshot =
        await _queries.users.where('email', isEqualTo: email).get();
    if (_querySnapshot.size > 0) {
      return UserModel.fromMap(_querySnapshot.docs[0].data());
    }
    return null;
  }

  Future<void> sendTextMessage({
    @required String content,
    @required String receiverEmail,
    @required DocumentReference chat,
  }) async {
    final message = TextMessageModel.now(
      senderEmail: currentUserModel.email,
      receiverEmail: receiverEmail,
      content: content,
    );
    await _sendMessage(chat: chat, message: message);
  }

  Future<void> sendLocationMessage({
    @required List<double> coords,
    @required String receiverEmail,
    @required DocumentReference chat,
  }) async {
    final message = LocationMessageModel(
      coords: coords,
      createdAt: Timestamp.now(),
      receiverEmail: receiverEmail,
      senderEmail: currentUserModel.email,
    );
    await _sendMessage(chat: chat, message: message);
  }

  Future<void> _sendMessage({
    @required DocumentReference chat,
    @required MessageModel message,
  }) async {
    await chat.collection('messages').add(message.toMap());
  }
}
