import './../Models/menu.model.dart';

class Controller {
  static Controller _instance;

  static Controller get instance {
    if (_instance == null) _instance = new Controller();
    return _instance;
  }

  Future<List<FoodCategory>> _foodCategories;
  Future<List<Food>> _foods;

  Future<List<FoodCategory>> get foodCategories {
    if (_foodCategories == null) _foodCategories = Model.instance.foodCategories;
    return _foodCategories;
  }

  Future<List<Food>> get foods {
    if (_foods == null) _foods = Model.instance.foods;
    return _foods;
  } 

  Future<List<Food>> filterFoods(String category) async {
    List<Food> _foods = await foods;
    int idCategory = await getIdCategory(category);
    if (idCategory == -1) return _foods;
    return _foods.where((_food) => _food.idFoodCategory == idCategory).toList();
  }

  Future<int> getIdCategory(String category) async {
    List<FoodCategory> _foodCategories = await foodCategories;
    for (var item in _foodCategories) {
      if (item.name == category) return item.id;
    }
    return -1;
  }

  Future<List<Food>> searchFoods(Future<List<Food>> foods, String keyword) async {
    List<Food> _foods = await foods;
    return _foods.where((_food) => _food.name.toLowerCase().indexOf(keyword.toLowerCase()) != -1).toList();
  }

}