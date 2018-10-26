import './../Models/menu.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<FoodCategory>> get foodCategories => Model.instance.foodCategories;
}