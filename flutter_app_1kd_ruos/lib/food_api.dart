import 'package:flutter_app_1kd_ruos/food.dart';

class FoodApi{
  static List<Food> getFoodSuggestions(){
    return [Food(name: "pizza"), Food(name: "kebab")];
  }
}