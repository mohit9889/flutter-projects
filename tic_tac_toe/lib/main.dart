import 'package:flutter/material.dart';
import 'package:tictactoe/Screens/game_screen.dart';
import 'package:tictactoe/Screens/room_screen.dart';

void main() => runApp(MyaApp());

class MyaApp extends StatefulWidget {
  @override
  _MyaAppState createState() => _MyaAppState();
}

class _MyaAppState extends State<MyaApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RoomScreen(
      ),
    );
  }
}
