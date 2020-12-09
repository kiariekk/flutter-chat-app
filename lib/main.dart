import 'package:flutter/material.dart';
import 'package:flutter_chat_app/di/getIt.dart';
import 'package:flutter_chat_app/presentation/app.dart';

void main() async {
  await GetItUtils.setup();
  runApp(App());
}
