import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/core/mixins/mappeable_model.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';

class ChatModel implements MappeableModel {
  final List<ChatModelUser> users;
  final ChatModelLastMessage lastMessage;

  const ChatModel({
    @required this.users,
    @required this.lastMessage,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      users: map["users"]
          .map<ChatModelUser>((user) => ChatModelUser.fromMap(user))
          .toList(),
      // users: map["users"] as List<ChatModelUser>,
      lastMessage: ChatModelLastMessage.fromMap(map["lastMessage"]),
    );
  }

  factory ChatModel.blank({
    @required ChatModelUser user1,
    @required ChatModelUser user2,
  }) {
    return ChatModel(
      users: [user1, user2],
      lastMessage: ChatModelLastMessage.blank(),
    );
  }

  ChatModelUser get otherUser {
    final currentUserEmail = AuthService.currentUser.email;
    return users.firstWhere((user) => user.email != currentUserEmail);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "users": users.map((user) => user.toMap()).toList(),
      "lastMessage": lastMessage.toMap(),
    };
  }
}

class ChatModelUser implements MappeableModel {
  final String username;
  final String email;

  const ChatModelUser({
    @required this.username,
    @required this.email,
  });

  factory ChatModelUser.fromMap(Map<String, dynamic> map) {
    return ChatModelUser(
      username: map["username"],
      email: map["email"],
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

class ChatModelLastMessage implements MappeableModel {
  final String content;
  final Timestamp createdAt;

  const ChatModelLastMessage({
    @required this.content,
    @required this.createdAt,
  });

  factory ChatModelLastMessage.fromMap(Map<String, dynamic> map) {
    return ChatModelLastMessage(
      content: map["content"],
      createdAt: map["createdAt"],
    );
  }

  factory ChatModelLastMessage.blank() {
    return ChatModelLastMessage(
      content: '',
      createdAt: Timestamp.now(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "createdAt": createdAt,
    };
  }
}
