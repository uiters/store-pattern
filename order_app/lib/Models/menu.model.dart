import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import './connectServer.dart';
import './../Constants/queries.dart';

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    return _instance;

  }

  Future<List<FoodCategory>> get foodCategories => getFoodCategories();
  Future<List<Food>> get foods => getFoods();
  

  static Future<List<FoodCategory>> getFoodCategories() async {

    Future<List> futureFoodCategories = MySqlConnection.instance.executeQuery(QUERY_GET_FOOD_CATEGORIES);
    return parseFoodCate(futureFoodCategories);

  }

  static Future<List<Food>> getFoods() async {

    Future<List> futureFoods = MySqlConnection.instance.executeQuery(QUERY_GET_FOODS);
    return parseFood(futureFoods);

  }

  static Future<List<FoodCategory>> parseFoodCate(Future<List> foodCategories) async  {

    List<FoodCategory> futureFoodCategories = [];
    await foodCategories.then((values){
      values.forEach((value){
        futureFoodCategories.add(FoodCategory.fromJson(value));
      });
    });
    return futureFoodCategories;

  }

  static Future<List<Food>> parseFood(Future<List> foods) async  {

    List<Food> futureFoods = [];
    await foods.then((values){
      values.forEach((value){
        futureFoods.add(Food.fromJson(value));
      });
    });
    return futureFoods;

  }

}

class FoodCategory {

  int id;
  String name;

  FoodCategory({
    this.id,
    this.name
  });

  FoodCategory.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.name = json['Name'];
  }
}

class Food {

  int id;
  String name;
  int idFoodCategory;
  double price;
  Uint8List image;

  Food({
    this.id,
    this.name,
    this.idFoodCategory,
    this.price,
    this.image
  });

  Food.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.name = json['Name'];
    this.idFoodCategory = int.parse(json['IDCategory']);
    this.price = double.parse(json['Price']);
    this.image = base64.decode(json['Image']);
  }
}