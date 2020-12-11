import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatRouteParams {
  final DocumentReference chatDoc;
  final String username;
  final String email;

  const ChatRouteParams({
    @required this.chatDoc,
    @required this.username,
    @required this.email,
  });
}
