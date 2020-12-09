import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/json_model.dart';

class Contact implements JsonModel {
  final String name;
  final String email;
  final LastMessage lastMessage;

  const Contact({
    @required this.name,
    @required this.email,
    @required this.lastMessage,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      email: map["email"] ?? "",
      name: map["name"] ?? "",
      lastMessage: LastMessage.fromMap(map["lastMessage"]),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "lastMessage": lastMessage.toMap(),
    };
  }
}

class LastMessage implements JsonModel {
  final String content;
  final Timestamp createdAt;

  const LastMessage({
    @required this.content,
    @required this.createdAt,
  });

  factory LastMessage.fromMap(Map<String, dynamic> map) {
    return LastMessage(
      content: map["content"],
      createdAt: map["createdAt"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "createdAt": createdAt,
    };
  }
}
