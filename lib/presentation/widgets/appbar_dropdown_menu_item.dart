import 'package:flutter/material.dart';

class AppBarDropdownMenuItem extends StatelessWidget {
  final Icon icon;
  final String value;
  final Widget title;
  final void Function() onPressed;

  const AppBarDropdownMenuItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.value,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 10),
        title,
      ],
    );
  }
}
