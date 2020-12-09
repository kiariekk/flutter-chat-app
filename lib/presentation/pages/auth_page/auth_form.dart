import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/services/auth_service.dart';
import 'package:flutter_chat_app/presentation/widgets/primary_button.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  _AuthMode _authMode = _AuthMode.SignUp;
  String _username = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_authMode == _AuthMode.SignUp)
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value.isEmpty || value.length < 3) {
                    return 'Please enter a longer value';
                  }
                  return null;
                },
                onSaved: (newValue) => _username = newValue,
              ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value.isEmpty || value.length < 3) {
                  return 'Please enter a longer value';
                }
                return null;
              },
              onSaved: (newValue) => _email = newValue,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value.isEmpty || value.length < 3) {
                  return 'Please enter a longer value';
                }
                return null;
              },
              onSaved: (newValue) => _password = newValue,
            ),
            SizedBox(height: 15),
            PrimaryButton(
              text: _authMode == _AuthMode.SignUp ? 'Sign Up' : 'Sign In',
              onPressed: _submit,
              isLoading: _isLoading,
            ),
            FlatButton(
              child: Text(
                _authMode == _AuthMode.SignUp
                    ? 'Already have an account? Sign In'
                    : 'Not have an account? Sign Up',
              ),
              onPressed: () {
                setState(() {
                  _authMode = _authMode == _AuthMode.SignUp
                      ? _AuthMode.SignIn
                      : _AuthMode.SignUp;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    final form = _formKey.currentState;
    if (!form.validate()) return;
    form.save();
    _setLoading(true);
    _authMode == _AuthMode.SignUp
        ? await AuthService.signUp(
            username: _username,
            email: _email,
            password: _password,
          )
        : await AuthService.signIn(
            email: _email,
            password: _password,
          );
    _setLoading(false);
  }

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }
}

enum _AuthMode {
  // ignore: unused_field
  SignIn,
  SignUp,
}
