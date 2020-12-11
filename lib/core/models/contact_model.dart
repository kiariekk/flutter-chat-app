import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/mappeable_model.dart';

class ContactModel implements MappeableModel {
  final String name;
  final String email;
  final LastMessage lastMessage;

  const ContactModel({
    @required this.name,
    @required this.email,
    @required this.lastMessage,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      email: map["email"] ?? "",
      name: map["name"] ?? "",
      lastMessage: LastMessage.fromMap(map["lastMessage"]),
    );
  }

  factory ContactModel.blank({
    @required name,
    @required email,
  }) {
    return ContactModel(
      name: name,
      email: email,
      lastMessage: LastMessage.blank(),
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

class LastMessage implements MappeableModel {
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

  factory LastMessage.blank() {
    return LastMessage(
      content: '',
      createdAt: Timestamp.now(),
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
