import 'dart:convert';

import './../Models/food.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = Controller();
    return _instance;
  }

  Future<List<Food>> _foods;

  Future<List<Food>> get foods {
    if (_foods == null) _foods = Model.instance.getFoods();
    return _foods;
  }

  Future<bool> deleteFood(int id) => Model.instance.deleteFood(id);

  void deleteFoodToLocal(int id) async {
    int index = await findIndex(id);
    (await foods).removeAt(index);
  }

  Future<int> findIndex(int id) async {
    for (var i = 0; i < (await foods).length; i++) {
      if ((await foods)[i].id == id) return i;
    }
    return -1;
  }

  Future<bool> insertFood(String name, double price, int idCategory, String image) {
    return Model.instance.insertFood(name, price, idCategory, image);
  }

  void insertFoodToLocal(String _name, int _idCategory, String _category, double _price,
      String _image) async {
    int idMax = await Model.instance.getIDMax();
    Food food = Food(idMax, _name, _idCategory, _category, _price, base64.decode(_image));
    (await foods).add(food);
  }

  Future<bool> isFoodExists(int id) => Model.instance.isFoodExists(id);

  Future<List<Food>> searchFoods(String keyword) async {
    List<Food> items = await foods;
    if (keyword.trim() == '') return items;
    return items
        .where((item) => item.name.toUpperCase().indexOf(keyword.toUpperCase()) != -1)
        .toList();
  }

  Future<bool> updateFood(
      int id, String name, double price, int idCategory, String image) {
    return Model.instance.updateFood(id, name, price, idCategory, image);
  }

  void updateFoodToLocal(int _id, String _name, int _idCategory, String _category,
      double _price, String _image) async {
    int index = await findIndex(_id);
    (await foods)[index].name = _name;
    (await foods)[index].idCategory = _idCategory;
    (await foods)[index].category = _category;
    (await foods)[index].price = _price;
    (await foods)[index].image = base64.decode(_image);
  }
}
