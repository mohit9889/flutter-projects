import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recipe/meal_generator.dart';
import 'package:recipe/model.dart';
import 'package:recipe/Screens/recipe_page.dart';

class RandomMealPage extends StatefulWidget {
  @override
  _RandomMealPageState createState() => _RandomMealPageState();
}

class _RandomMealPageState extends State<RandomMealPage> {
  MealGenerator mealGenerator = MealGenerator();
  Model data=new Model();
  bool isPressed = false;

  Future getData() async {

    data = await mealGenerator.getRandomMeal();
    setState(() {
      data = data;
    });
//    isPressed = false;
    //print(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Feeling Hungry?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Get a random meal by clicking below',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Text(
                  'Get Meal 🍔',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Montserrat'),
                ),
                color: Colors.blue[300],
                onPressed: () {
                  setState(() {
                    isPressed = true;
                    getData();
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: isPressed ? container() : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  container() {
    return Column(
      children: <Widget>[
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Image(
              image: NetworkImage(data.imgUrl),
            ),
          ),
          width: 250,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          data.mealName,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          child: Text(
            'See Recipe',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: 'Montserrat'),
          ),
          color: Colors.blue[300],
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecipePage(
                data: data,
              );
            }));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
        ),
      ],
    );
  }
}
