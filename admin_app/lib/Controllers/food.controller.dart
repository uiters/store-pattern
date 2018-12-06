import 'dart:io';

import 'package:image_picker/image_picker.dart';

import './../Models/food.model.dart';

class Controller {

  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<Food>> _foods;

  Future<List<Food>> get foods {
    if (_foods == null) _foods = Model.instance.getFoods();
    return _foods;
  }

  Future<bool> insertFood(String name, double price, int idCategory, String image) {
    return Model.instance.insertFood(name, price, idCategory, image);
  }

  Future<bool> updateFood(int id, String name) {
    return Model.instance.updateFood(id, name);
  }

  void reloadFoods() {
    _foods = Model.instance.getFoods();
  }

  Future<List<Food>> searchFoods(String keyword) async {
    List<Food> items = await foods;
    if (keyword.trim() == '') return items;
    return items.where((item) => item.name.toUpperCase().indexOf(keyword.toUpperCase()) != -1).toList();
  }

  Future<File> getImage() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

}