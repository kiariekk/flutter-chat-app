import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/di/getIt.dart';
import 'package:flutter_chat_app/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetItUtils.setup();
  await Firebase.initializeApp();
  runApp(App());
}
