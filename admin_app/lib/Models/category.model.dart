import './connectServer.dart';

import './food.model.dart' as foodModel;

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

  Future<bool> updateCategory(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.UPDATE_CATEGORY,
      parameter: [id, name]
    );
  }

  Future<bool> deleteCategory(int id) {
    return MySqlConnection.instance.executeNoneQuery(
      queries.DELETE_CATEGORY,
      parameter: [id]
    );
  }

  Future<bool> isCategoryExists(int id) async { // check category exists on food
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(
      queries.IS_CATEGORY_EXISTS,
      parameter: [id]
    );
    return (await foodModel.Model.parseFood(futureFoods)).length > 0;
  }

  Future<int> getIDMax() async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(
      queries.GET_ID_CATEGORY_MAX
    );
    return (await parseCategory(futureFoods))[0].id;
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

  Category(int _id, String _name) {
    id = _id;
    name = _name;
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['ID']);
    name = json['Name'];
  }
}