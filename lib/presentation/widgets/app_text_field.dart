import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String label;

  const AppFormField({
    Key key,
    @required this.onSaved,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Value can\'t be empty.';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
