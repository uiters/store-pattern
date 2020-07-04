import './../Constants/queries.dart' as queries;
import './food.model.dart' as foodModel;
import 'connect_server.dart';

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

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) {
      _instance = Model();
    }
    return _instance;
  }

  Future<bool> deleteCategory(int id) {
    return MySqlConnection.instance.executeNoneQuery(queries.DELETE_CATEGORY, parameter: [id]);
  }

  Future<List<Category>> getCategories() async {
    Future<List> futureCategories = MySqlConnection.instance.executeQuery(queries.GET_CATEGORIES);
    return parseCategory(futureCategories);
  }

  Future<int> getIDMax() async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(queries.GET_ID_CATEGORY_MAX);
    return (await parseCategory(futureFoods))[0].id;
  }

  Future<bool> insertCategory(String name) {
    return MySqlConnection.instance.executeNoneQuery(queries.INSERT_CATEGORY, parameter: [name]);
  }

  Future<bool> isCategoryExists(int id) async {
    // check category exists on food
    Future<List> futureFoods =
        MySqlConnection.instance.executeQuery(queries.IS_CATEGORY_EXISTS, parameter: [id]);
    return (await foodModel.Model.parseFood(futureFoods)).isNotEmpty;
  }

  Future<List<Category>> parseCategory(Future<List> futureCategories) async {
    List<Category> categories = [];
    await futureCategories.then((values) {
      values.forEach((value) => categories.add(Category.fromJson(value)));
    });
    return categories;
  }

  Future<bool> updateCategory(int id, String name) {
    return MySqlConnection.instance.executeNoneQuery(queries.UPDATE_CATEGORY, parameter: [id, name]);
  }
}
