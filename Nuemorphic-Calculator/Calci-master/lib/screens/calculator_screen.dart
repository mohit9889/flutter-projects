import 'package:calculator/screens/history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//constants
import 'package:calculator/utilities/constants.dart';
import 'package:calculator/utilities/history_data.dart';
//calculator widgets
import 'package:calculator/components/calculator_button.dart';
import 'package:calculator/components/button_row.dart';

//services
import 'package:calculator/utilities/calculation.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = '0';
  String expression = "";
  String prevExp = "";
  bool decimal = false;
  bool _isPressed = false;

  void makeExpression(String symbol) {
    if (expression.length <= 17) {
      if (symbol == '+' || symbol == '-' || symbol == '*' || symbol == '/') {
        if (expression == "0" && symbol == "-") {
          expression = '-';
        } else {
          String current = expression[expression.length - 1];
          if (expression.length > 0 &&
              (current == "+" ||
                  current == "-" ||
                  current == "*" ||
                  current == "/")) {
            String temp = expression.substring(0, expression.length - 1);
            temp = temp + symbol;

            expression = temp;
            decimal = false;
          } else if (expression.length > 0) {
            expression += symbol;
            decimal = false;
          }
        }
      } else if (symbol == '.') {
        if (decimal == false) {
          expression += '.';

          decimal = true;
        }
      } else if (symbol == '=') {
        var result = getResult(expression);
        prevExp = expression;
        results.add([expression, result]);
        setState(() {
          expression = result;
          prevExp += "";
          decimal = true;
        });
      } else {
        expression += symbol;
      }
      setState(() {
        expression = expression + "";
      });
    } else if (symbol == "=") {
      var result = getResult(expression);
      results.add([expression, result]);
      setState(() {
        prevExp = expression;
        expression = result;
        decimal = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.history,
                color: KNumberTextColor,
              ),
              onPressed: () async {
                var res = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return HistoryScreen();
                }));
                setState(() {
                  expression = res[1];
                  prevExp = res[0];
                });
              },
            )
          ],
          title: Text(
            '  Calculator',
            style: KAppBarTitleStyle,
          ),
          elevation: 0,
          backgroundColor: KBackgroundColor,
        ),
        backgroundColor: KBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  prevExp,
                  textAlign: TextAlign.right,
                  style: KPreviousTextStyle,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  expression,
                  style: expression.length < 10
                      ? KCalculationTextStyle
                      : KCalculationSmallTextStyle,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Expanded(
                flex: 2,
                child: ButtonRow(
                  children: [
                    CalculatorButton(
                      text: 'AC',
                      style: KSpecialOperatorTextStyle,
                      onPressed: () {
                        print('AC');
                        setState(() {
                          expression = "";
                          prevExp = "";
                        });
                      },
                    ),
                    CalculatorButton(
                      icon: Icons.backspace,
                      style: KSpecialOperatorTextStyle,
                      onPressed: () {
                        if (expression.length > 0) {
                          if (expression[0] == '.') {
                            decimal = false;
                          }
                          setState(() {
                            expression = expression.substring(1);
                          });
                        }
                      },
                    ),
                    CalculatorButton(
                      text: '%',
                      style: KSpecialOperatorTextStyle,
                      onPressed: () {
                        print('%');
                        makeExpression('%');
                      },
                    ),
                    CalculatorButton(
                      text: '÷',
                      style: KOperatorTextStyle,
                      onPressed: () {
                        print('÷');
                        makeExpression('/');
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonRow(
                  children: [
                    CalculatorButton(
                      text: '7',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('7');
                        makeExpression('7');
                      },
                    ),
                    CalculatorButton(
                      text: '8',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('8');
                        makeExpression('8');
                      },
                    ),
                    CalculatorButton(
                      text: '9',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('9');
                        makeExpression('9');
                      },
                    ),
                    CalculatorButton(
                      text: '×',
                      style: KOperatorTextStyle,
                      onPressed: () {
                        print('×');
                        makeExpression('*');
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonRow(
                  children: [
                    CalculatorButton(
                      text: '4',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('4');
                        makeExpression('4');
                      },
                    ),
                    CalculatorButton(
                      text: '5',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('5');
                        makeExpression('5');
                      },
                    ),
                    CalculatorButton(
                      text: '6',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('6');
                        makeExpression('6');
                      },
                    ),
                    CalculatorButton(
                      text: '-',
                      style: KOperatorTextStyle,
                      onPressed: () {
                        print('-');
                        makeExpression('-');
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonRow(
                  children: [
                    CalculatorButton(
                      text: '1',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('1');
                        makeExpression('1');
                      },
                    ),
                    CalculatorButton(
                      text: '2',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('2');
                        makeExpression('2');
                      },
                    ),
                    CalculatorButton(
                      text: '3',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('3');
                        makeExpression('3');
                      },
                    ),
                    CalculatorButton(
                      text: '+',
                      style: KOperatorTextStyle,
                      onPressed: () {
                        print('+');
                        makeExpression('+');
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonRow(
                  children: [
                    CalculatorButton(
                      text: '0',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('0');
                        makeExpression('0');
                      },
                      isZero: true,
                    ),
                    CalculatorButton(
                      text: '.',
                      style: KCalculatorTextStyle,
                      onPressed: () {
                        print('.');
                        makeExpression('.');
                      },
                    ),
                    CalculatorButton(
                      text: '=',
                      style: KOperatorTextStyle,
                      onPressed: () {
                        print('=');
                        makeExpression('=');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
