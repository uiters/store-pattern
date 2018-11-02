import './../Models/menu.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<FoodCategory>> get foodCategories => Model.instance.foodCategories;
  Future<List<Food>> get foods => Model.instance.foods;

  Future<List<Food>> filterFoods(String category) async {
    List<Food> _foods = await foods;
    int idCategory = await getIdCategory(category);
    if (idCategory == -1) return _foods;
    return _foods.where((_food) => _food.idFoodCategory == idCategory);
  }

  Future<int> getIdCategory(String category) async {
    List<FoodCategory> _foodCategories = await foodCategories;
    for (var item in _foodCategories) {
      if (item.name == category) return item.id;
    }
    return -1;
  }
}