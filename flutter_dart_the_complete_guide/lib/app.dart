import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final Function _onPressed;

  App(this._onPressed);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text("Increase awesomeness"),
      textColor: Colors.orange,
      borderSide: BorderSide(color: Colors.orange),
      textTheme: ButtonTextTheme.accent,
      onPressed: _onPressed,
    );
  }
}
