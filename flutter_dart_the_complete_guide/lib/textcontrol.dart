import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final int _counter;

  TextControl(this._counter);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_counter',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
