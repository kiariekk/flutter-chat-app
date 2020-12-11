import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/mappeable_model.dart';

class MessageModel implements MappeableModel {
  final String senderEmail;
  final String receiverEmail;
  final String content;
  final Timestamp createdAt;

  MessageModel({
    @required this.senderEmail,
    @required this.receiverEmail,
    @required this.content,
    @required this.createdAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      receiverEmail: map["receiverEmail"],
      senderEmail: map["senderEmail"],
      content: map["content"] ?? "",
      createdAt: map["createdAt"],
    );
  }

  factory MessageModel.now({
    @required String senderEmail,
    @required String receiverEmail,
    @required String content,
  }) {
    return MessageModel(
      senderEmail: senderEmail,
      receiverEmail: receiverEmail,
      content: content,
      createdAt: Timestamp.now(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "senderEmail": senderEmail,
      "receiverEmail": receiverEmail,
      "content": content,
      "createdAt": createdAt,
    };
  }
}
