class Model {
  String mealName,
      imgUrl,
      mealVideoUrl,
      mealInstructions,
      mealCategory,
      mealArea;
  Map ingredient;



  Model({
    this.mealName="",
    this.imgUrl="",
    this.ingredient,
    this.mealInstructions="",
    this.mealVideoUrl=" ",
    this.mealArea="",
    this.mealCategory="",
  });
}
