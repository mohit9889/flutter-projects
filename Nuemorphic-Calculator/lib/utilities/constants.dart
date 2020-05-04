import 'package:flutter/material.dart';

const KBackgroundColor = Color.fromRGBO(239, 238, 238, 1);
const KOperatorTextColor = Color.fromRGBO(238, 134, 48, 1);
const KNumberTextColor = Color.fromRGBO(38, 38, 38, 1);
const KSpecialOperatorTextColor = Color.fromRGBO(171, 171, 171, 1);
const List<Color> _fill = <Color>[
  Color.fromRGBO(245, 245, 245, 1),
  KBackgroundColor,
  Color.fromRGBO(245, 245, 245, 1),
];

const KCalculationTextStyle = TextStyle(
  fontSize: 55,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
);

const KCalculationSmallTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
);

const KCalculatorTextStyle = TextStyle(
  color: KNumberTextColor,
  fontSize: 22,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w900,
);

const KSpecialOperatorTextStyle = TextStyle(
  color: KSpecialOperatorTextColor,
  fontSize: 22,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w900,
);

const KButtonPressedTextStyle = TextStyle(
  color: KOperatorTextColor,
  fontSize: 22,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w900,
);

const KOperatorTextStyle = TextStyle(
  color: KOperatorTextColor,
  fontSize: 30,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w900,
);

const KOperatorPressedTextStyle = TextStyle(
  color: KNumberTextColor,
  fontSize: 30,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w900,
);

const KPreviousTextStyle = TextStyle(
  fontSize: 25,
  color: KSpecialOperatorTextColor,
);

const KAppBarTitleStyle = TextStyle(
  fontFamily: 'Montserrat',
  color: KNumberTextColor,
  fontWeight: FontWeight.w900,
);

const KConvexButtonBoxShadow = BoxDecoration(
  color: KBackgroundColor,
  borderRadius: BorderRadius.all(Radius.circular(50)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(216, 213, 208, 1),
      offset: Offset(5.0, 5.0),
      blurRadius: 15.0,
    ),
    BoxShadow(
      color: Colors.white,
      offset: Offset(-5.0, -5.0),
      blurRadius: 15.0,
    )
  ],
);

const KConcaveButtonShadow = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(50)),
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: _fill,
    stops: [0.1, 0.5, 0.9],
  ),
);
