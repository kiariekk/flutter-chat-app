import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class SendLocationParams {
  final DocumentReference chatDoc;
  final String receiverEmail;

  const SendLocationParams({
    @required this.chatDoc,
    @required this.receiverEmail,
  });
}
