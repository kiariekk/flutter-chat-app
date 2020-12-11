import 'package:flutter/foundation.dart';

class AddContactParams {
  final String username;
  final String email;

  const AddContactParams({
    @required this.username,
    @required this.email,
  });
}
