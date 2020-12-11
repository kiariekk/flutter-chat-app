import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/themes/app_colors.dart';
import 'package:flutter_chat_app/presentation/widgets/loading_indicator.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;

  const PrimaryButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingIndicator();
    }
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.lightColor,
        ),
      ),
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
    );
  }
}
