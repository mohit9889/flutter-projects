import 'package:calculator/utilities/history_data.dart';
import 'package:flutter/material.dart';
import 'package:calculator/utilities/constants.dart';

class HistoryScreen extends StatelessWidget {
  List<Widget> resultList = [];
  int len = results.length-1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: KNumberTextColor,
        ),
        title: Text(
          '  History',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: KNumberTextColor,
              fontWeight: FontWeight.w900),
        ),
        elevation: 0,
        backgroundColor: KBackgroundColor,
      ),
      backgroundColor: KBackgroundColor,
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onLongPress: () {
                  Navigator.pop(context, [results[i][0], results[i][1]]);
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        results[len-i][0] + "=",
                        style: KCalculationSmallTextStyle,
                      ),
                      Text(
                        results[len-i][1],
                        style: KCalculationSmallTextStyle,
                      ),
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width / 1.15,
                        color: Colors.grey[400],
                        margin: EdgeInsets.all(5.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
