import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/models/message_model.dart';

class LocationMessageModel extends MessageModel {
  final List<double> coords;

  const LocationMessageModel({
    @required this.coords,
    @required Timestamp createdAt,
    @required String senderEmail,
    @required String receiverEmail,
  }) : super(
          createdAt: createdAt,
          senderEmail: senderEmail,
          receiverEmail: receiverEmail,
        );

  factory LocationMessageModel.fromMap(Map<String, dynamic> map) {
    return LocationMessageModel(
      coords: map["coords"].map<double>((coord) => coord as double).toList(),
      createdAt: map["createdAt"],
      senderEmail: map["senderEmail"],
      receiverEmail: map["receiverEmail"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..putIfAbsent('coords', () => coords);
  }
}
