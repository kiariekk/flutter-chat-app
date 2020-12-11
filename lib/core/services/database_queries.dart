import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/core/di/getIt.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';

class DatabaseQueries {
  DatabaseQueries.singleton();

  final _firestore = FirebaseFirestore.instance;

  CollectionReference get users => _firestore.collection('users');

  CollectionReference get chats => _firestore.collection('chats');

  Query get allChatsOfCurrentUser {
    final currentUserModel = getIt<DatabaseService>().currentUserModel;
    return chats.where('users', arrayContains: {
      "username": currentUserModel.username,
      "email": currentUserModel.email,
    }).orderBy("lastMessage.createdAt", descending: true);
  }

  Query allMessagesIn(DocumentReference chatDoc) {
    return chatDoc.collection('messages').orderBy(
          'createdAt',
          descending: true,
        );
  }
}
