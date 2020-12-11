import 'package:flutter/foundation.dart';

class AddContactParams {
  final String name;
  final String email;

  const AddContactParams({
    @required this.name,
    @required this.email,
  });
}
