import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widgets/loading_indicator.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;

  const PrimaryButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    @required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingIndicator()
        : RaisedButton(
            child: Text(text),
            onPressed: onPressed,
          );
  }
}
