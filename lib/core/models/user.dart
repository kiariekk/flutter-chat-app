import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/json_model.dart';

class User implements JsonModel {
  final String username;
  final String email;

  const User({
    @required this.username,
    @required this.email,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      email: data['email'],
      username: data['username'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "email": email,
    };
  }
}
