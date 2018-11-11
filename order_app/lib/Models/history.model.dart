import './connectServer.dart';
import './../Constants/queries.dart' as queries;

import './home.model.dart' as home;
import './menu.model.dart' as menu;

class Model {

  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = new Model();
    return _instance;
  }

  Future<List<BillPlus>> getListBill() async {
    Future<List> futureBills = MySqlConnection.instance.executeQuery(
      queries.GET_BILLS,
      parameter: [new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)]
    );
    return parseBillPlus(futureBills);
  }

  Future<List<menu.Food>> getBillDetailByTable(int idTable) async {
    Future<List> futureFoods = MySqlConnection.instance.executeQuery(
      queries.GET_BILLDETAIL_BY_TABLE,
      parameter: [idTable]
    );
    return parseFood(futureFoods);
  }

  Future<List<BillPlus>> parseBillPlus(Future<List> bills) async {
    List<BillPlus> futureBills = [];
    await bills.then((values){
      values.forEach((value){
        futureBills.add(new BillPlus.fromJson(value));
      });
    });
    return futureBills;
  }

  Future<List<menu.Food>> parseFood(Future<List> foods) async  {
    List<menu.Food> futureFoods = [];
    await foods.then((values){
      values.forEach((value){
        futureFoods.add(new menu.Food.fromJson(value));
      });
    });
    return futureFoods;
  }
}

class BillPlus {

  int id;
  home.Table table;
  DateTime dateCheckOut;
  double discount;
  double totalPrice;

  BillPlus.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.dateCheckOut = DateTime.parse(json['DateCheckOut']);
    this.discount = double.parse(json['Discount']);
    this.totalPrice = double.parse(json['TotalPrice']);

    this.table.id = int.parse(json['IDTable']);
    this.table.name = json['Name'];
    this.table.addFoods(Model.instance.getBillDetailByTable(this.table.id));
  }

}
