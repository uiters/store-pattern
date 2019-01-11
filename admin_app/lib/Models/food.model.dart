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

  Future<bool> updateFood(int id, String name, double price, int idCategory, String image) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_FOOD,
      parameter: [id, name, price, idCategory, image]
    );
  }

  Future<bool> deleteFood(int id) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.DELETE_FOOD,
      parameter: [id]
    );
  }

  Future<bool> isFoodExists(int id) async {
    Future<List> futureAccs = MySqlConnection.instance.executeQuery(
      queries.IS_FOOD_EXISTS,
      parameter: [id]
    );
    return (await parseBillDetails(futureAccs)).length > 0;
  }

  Future<int> getIDMax() async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(
      queries.GET_ID_FOOD_MAX
    );
    return (await parseFood(futureFoods))[0].id;
  }

  Future<List<Food>> parseFood(Future<List> futureFoods) async  {
    List<Food> foods = [];
    await futureFoods.then((values) {
      values.forEach((value) => foods.add(new Food.fromJson(value)));
    });
    return foods;
  }

  Future<List<BillDetail>> parseBillDetails(Future<List> futureBillDetails) async  {
    List<BillDetail> billDetails = [];
    await futureBillDetails.then((values) {
      values.forEach((value) => billDetails.add(new BillDetail.fromJson(value)));
    });
    return billDetails;
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

  Food(int _id, String _name, int _idCategory, String _category, double _price, Uint8List _image) {
    id = _id;
    name = _name;
    idCategory = _idCategory;
    category = _category;
    price = _price;
    image = _image;
  }

  Food.fromJson(Map<String, dynamic> json) {
    this.id = json['IdFood'] != null ? int.parse(json['IdFood']) : int.parse(json['ID']);
    this.name = json['FoodName'] != null ? json['FoodName'] : '';
    this.idCategory = json['IDCategory'] != null ? int.parse(json['IDCategory']) : -1;
    this.category = json['CategoryName'] != null ? json['CategoryName'] : '';
    this.price = json['Price'] != null ? double.parse(json['Price']) : 0.0;
    this.idImange = json['IdImage'] != null ? int.parse(json['IdImage']) : -1;
    this.image = json['Image'] != null ? base64.decode(json['Image']) : null;
  }
}

class BillDetail {

  int idBill;
  int idFood;
  int quantity;

  BillDetail.fromJson(Map<String, dynamic> json) {
    this.idBill = int.parse(json['IDBill']);
    this.idFood = int.parse(json['IDFood']);
    this.quantity = int.parse(json['Quantity']);
  }

}