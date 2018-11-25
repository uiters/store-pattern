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
  
  Future<List<Category>> getCategories() async {
    Future<List> futureCategories = MySqlConnection.instance.executeQuery(
      queries.GET_CATEGORIES,
    );
    return parseCategory(futureCategories);
  }

  Future<List<Category>> parseCategory(Future<List> futureCategories) async  {
    List<Category> categories = [];
    await futureCategories.then((values) {
      if (values.length > 0)
      for (var item in values) {
        Category category = new Category.fromJson(item);
        categories.add(category);
      }
    });
    return categories;
  }
}

class Category {
  int id;
  String name;

  Category.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['ID']);
    name = json['Name'];
  }
}