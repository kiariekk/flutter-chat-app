import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/models/message_model.dart';

class TextMessageModel extends MessageModel {
  final String content;

  const TextMessageModel({
    @required this.content,
    @required Timestamp createdAt,
    @required String senderEmail,
    @required String receiverEmail,
  }) : super(
          createdAt: createdAt,
          senderEmail: senderEmail,
          receiverEmail: receiverEmail,
        );

  factory TextMessageModel.fromMap(Map<String, dynamic> map) {
    return TextMessageModel(
      receiverEmail: map["receiverEmail"],
      senderEmail: map["senderEmail"],
      content: map["content"] ?? "",
      createdAt: map["createdAt"],
    );
  }

  factory TextMessageModel.now({
    @required String senderEmail,
    @required String receiverEmail,
    @required String content,
  }) {
    return TextMessageModel(
      senderEmail: senderEmail,
      receiverEmail: receiverEmail,
      content: content,
      createdAt: Timestamp.now(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..putIfAbsent('content', () => content);
  }
}
