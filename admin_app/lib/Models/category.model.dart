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
      queries.GET_CATEGORIES
    );
    return parseCategory(futureCategories);
  }

  Future<bool> insertCategory(String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.INSERT_CATEGORY,
      parameter: [name]
    );
  }

  Future<List<Category>> parseCategory(Future<List> futureCategories) async  {
    List<Category> categories = [];
    await futureCategories.then((values) {
      values.forEach((value) => categories.add(new Category.fromJson(value)));
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