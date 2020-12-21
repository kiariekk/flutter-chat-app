import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/models/message_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMessageModel extends MessageModel {
  final LatLng coords;

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
      coords: LatLng(map["coords"][0], map["coords"][1]),
      createdAt: map["createdAt"],
      senderEmail: map["senderEmail"],
      receiverEmail: map["receiverEmail"],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..putIfAbsent('coords', () => [coords.latitude, coords.longitude]);
  }
}
