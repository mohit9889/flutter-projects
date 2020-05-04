import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

class MealGenerator {
  String mealName,
      imgUrl,
      mealVideoUrl,
      mealInstructions,
      mealCategory,
      mealArea;
  Map ingredient = Map();

  Future<Model> getRandomMeal() async {
    const url = 'https://www.themealdb.com/api/json/v1/1/random.php';

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      mealName = decodedData['meals'][0]['strMeal'];
      imgUrl = decodedData['meals'][0]['strMealThumb'];
      mealCategory = decodedData['meals'][0]['strCategory'];
      mealArea = decodedData['meals'][0]['strArea'];
      mealVideoUrl = decodedData['meals'][0]['strYoutube'];
      mealInstructions = decodedData['meals'][0]['strInstructions'];

      print(decodedData['meals'][0]);

      for (int i = 1; i <= 20; i++) {
        if(decodedData['meals'][0]['strIngredient$i']!=null){
          ingredient[decodedData['meals'][0]['strIngredient$i']] =
          decodedData['meals'][0]['strMeasure$i'];
        }

      }
      print(ingredient);

      Model data = Model(
          mealName: mealName,
          imgUrl: imgUrl,
          ingredient: ingredient,
          mealArea: mealArea,
          mealCategory: mealCategory,
          mealInstructions: mealInstructions,
          mealVideoUrl: mealVideoUrl);
      return data;
    } else {
      print('Response Error : ${response.statusCode}');
    }
  }
}
