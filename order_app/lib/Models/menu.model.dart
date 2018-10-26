import './connectServer.dart';
import './../Constants/queries.dart';

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    return _instance;

  }

  Future<List<FoodCategory>> get foodCategories => getFoodCategories();
  

  static Future<List<FoodCategory>> getFoodCategories() async {

    Future<List> futureFoodCategories = MySqlConnection.instance.executeQuery(QUERY_GET_FOOD_CATEGORIES);
    return parseFoodCate(futureFoodCategories);

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
  String image;

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
    this.idFoodCategory = int.parse(json['IdCategoryFood']);
    this.price = double.parse(json['Price']);
    this.image = json['Image'];
  }
}