import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingIndicator(),
    );
  }
}
