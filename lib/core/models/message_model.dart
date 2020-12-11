import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/mappeable_model.dart';

class MessageModel implements MappeableModel {
  final String senderId;
  final String receiverId;
  final String content;
  final Timestamp createdAt;

  MessageModel({
    @required this.senderId,
    @required this.receiverId,
    @required this.content,
    @required this.createdAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
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
