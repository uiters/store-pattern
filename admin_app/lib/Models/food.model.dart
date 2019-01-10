import 'dart:convert';
import 'dart:typed_data';

import './connectServer.dart';

import './../Constants/queries.dart' as queries;

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) {
      _instance = new Model();
    }
    return _instance;
  }
  
  Future<List<Food>> getFoods() async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(
      queries.GET_FOODS
    );
    return parseFood(futureFoods);
  }

  Future<bool> insertFood(String name, double price, int idCategory, String image) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_FOOD,
      parameter: [name, price, idCategory, image]
    );
  }

  Future<bool> updateFood(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_FOOD,
      parameter: [id, name]
    );
  }

  Future<List<Food>> parseFood(Future<List> futureFoods) async  {
    List<Food> foods = [];
    await futureFoods.then((values) {
      values.forEach((value) => foods.add(new Food.fromJson(value)));
    });
    return foods;
  }
}

class Food {
  int id;
  String name;
  int idCategory;
  String category;
  double price;
  int idImange;
  Uint8List image;

  Food.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['IdFood']);
    this.name = json['FoodName'];
    this.idCategory = int.parse(json['IDCategory']);
    this.category = json['CategoryName'];
    this.price = double.parse(json['Price']);
    this.idImange = int.parse(json['IdImage']);
    this.image = json['Image'] != null ? base64.decode(json['Image']) : null;
  }
}