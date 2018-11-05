import './connectServer.dart';
import './../Constants/queries.dart';

import './menu.model.dart' as menu;

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    getTables();
    return _instance;
  }

  Future<List<Table>> get tables => getTables();

  static Future<List<Table>> getTables() async {
    Future<List> futureTables = MySqlConnection.instance.executeQuery(QUERY_GET_TABLES);
    return parse(futureTables);
  }

  static Future<List<Table>> parse(Future<List> tables) async  {

    List<Table> futureTables = [];
    await tables.then((values){
      values.forEach((value){
        futureTables.add(new Table.fromJson(value));
      });
    });
    return futureTables;
  }

}

class Table {
  int id;
  String name;
  int status;
  List<menu.Food> _foods;

  Table({this.id, this.name, this.status});

  Table.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.name = json['Name'];
    this.status = int.parse(json['Status']);
    this._foods = new List<menu.Food>();
  }        

  List<menu.Food> get foods {
    if (_foods == null) _foods = new List<menu.Food>();
    return _foods;
  }

  List<menu.Food> combineFoods(List<menu.Food> _menuFoods) {
    List<menu.Food> menuFoods = List<menu.Food>.from(_menuFoods);
    if (foods != null)
    for (var i = 0; i < foods.length; i++) {
      for (var j = 0; j < menuFoods.length; j++) {
        if (foods[i].id == menuFoods[j].id) {
          menuFoods[j] = foods[i];
          break;
        }
      }
    }
    return menuFoods;
  }

  void clearMenuFoods(List<menu.Food> menuFoods) {
    for (var i = 0; i < menuFoods.length; i++) {
      menuFoods[i].quantity = 0;
    }
  }

  void addFood(menu.Food food) {
    // Check food exists in foods
    // exists: update food, not exists: add to foods

    int index = findIndexFood(food);
    if (index == -1) { //add to foods
    menu.Food _food = new menu.Food(food);
      _food.quantity = 1;
      foods.add(_food);
    } else { // update food
      foods[index].quantity++;
    }
  }

  void subFood(menu.Food food) {
    int index = findIndexFood(food);
    if (index != -1) {
      if (foods[index].quantity > 1) {
        foods[index].quantity--;
      } else {
        deleteFood(foods[index]);
      }
    }
  }

  void deleteFood(menu.Food food) {
    int index = findIndexFood(food);
    if (index != -1) {
      foods.remove(foods[index]);
    }
  }

  int findIndexFood(menu.Food food) {
    if (foods != null)
    for (var i = 0; i < foods.length; i++) {
      if (food.id == foods[i].id) {
        return i;
      }
    }
    return -1;
  }
}
