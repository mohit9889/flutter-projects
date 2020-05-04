import 'package:flutter/material.dart';
//screens
import 'package:calculator/screens/calculator_screen.dart';
//constants
import 'package:calculator/utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Monserrta',
        backgroundColor: KBackgroundColor,
      ),
      home: CalculatorScreen(),
    );
  }
}
