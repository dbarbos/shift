import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'board_message.dart';

void main() => runApp(new ShiftApp());

class ShiftApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shift",
      theme: ThemeData(),
      home: BoardMessage(),
    );
  }
}