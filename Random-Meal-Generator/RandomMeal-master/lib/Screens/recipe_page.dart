import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe/model.dart';

class RecipePage extends StatelessWidget {
  final Model data;
  RecipePage({this.data});

  List<Widget> textWidget(Map ingredients) {
    List<String> ingredient = [];
    List<String> measure = [];
    ingredients.forEach((k, v) => ingredient.add(k));
    ingredients.forEach((k, v) => measure.add(v));

    print('I : ${ingredient.length}');
    print('M : ${measure.length}');

    List<Widget> textList = List<Widget>();
    for (int i = 0; i < ingredients.length; i++) {
      textList.add(
        Text(
          '${ingredient[i]} - ${measure[i]}',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Montserrat',
          ),
        ),
      );
    }

    return textList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      data.mealName,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: FittedBox(
                    child: Image.network(data.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Ingredients :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: textWidget(data.ingredient),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${data.mealInstructions}',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Video',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
