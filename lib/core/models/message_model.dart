import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/mappeable_model.dart';
import 'package:flutter_chat_app/core/models/location_message_model.dart';
import 'package:flutter_chat_app/core/models/text_message_model.dart';

abstract class MessageModel implements MappeableModel {
  final String senderEmail;
  final String receiverEmail;
  final Timestamp createdAt;

  const MessageModel({
    @required this.senderEmail,
    @required this.receiverEmail,
    @required this.createdAt,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "senderEmail": senderEmail,
      "receiverEmail": receiverEmail,
      "createdAt": createdAt,
    };
  }
}

class MessageModelFactory {
  const MessageModelFactory._();

  static MessageModel createFromMap(Map<String, dynamic> map) {
    final isTextMessage = map.containsKey('content');
    if (isTextMessage) {
      return TextMessageModel.fromMap(map);
    }

    final isLocationMessage = map.containsKey('coords');
    if (isLocationMessage) {
      return LocationMessageModel.fromMap(map);
    }

    throw ArgumentError(
      'The map: $map does not contain the right parameters or is unimplemented.',
    );
  }
}
