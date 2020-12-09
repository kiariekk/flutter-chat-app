import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/json_model.dart';

class Message implements JsonModel {
  final String senderId;
  final String receiverId;
  final String content;
  final Timestamp createdAt;

  Message({
    @required this.senderId,
    @required this.receiverId,
    @required this.content,
    @required this.createdAt,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      receiverId: map["receiverId"],
      senderId: map["senderId"],
      content: map["content"] ?? "",
      createdAt: map["createdAt"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
      "createdAt": createdAt,
    };
  }
}
