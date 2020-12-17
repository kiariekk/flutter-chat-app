import 'package:flutter/material.dart';

class LocationMessage extends StatelessWidget {
  final List<double> coords;
  final bool sendByCurrentUser;

  const LocationMessage({
    Key key,
    @required this.coords,
    @required this.sendByCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
