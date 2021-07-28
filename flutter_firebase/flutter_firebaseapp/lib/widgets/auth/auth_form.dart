import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFn);

  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _username;
  var _email;
  var _password;

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      widget.submitFn(
        _email,
        _username,
        _password,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Email must be valid';
                    }

                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Input email'),
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return "Username can't be empty";
                      }

                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Input username'),
                    onSaved: (value) {
                      _username = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 7) {
                      return 'Password must be longer';
                    }

                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Input password'),
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: _trySubmit,
                  child: Text(_isLogin ? 'Login' : 'Sigup'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'I already have an account'),
                ),
              ],
            ),
          ),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
