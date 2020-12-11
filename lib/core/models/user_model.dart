import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/mappeable_model.dart';

class UserModel implements MappeableModel {
  final String username;
  final String email;

  const UserModel({
    @required this.username,
    @required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
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
