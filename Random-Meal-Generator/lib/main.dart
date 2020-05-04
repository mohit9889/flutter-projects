import 'package:flutter/material.dart';
import 'Screens/random_mael_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomMealPage(),
    );
  }
}
