import './../Constants/queries.dart' as queries;
import './home.model.dart' as home;
import './login.model.dart' as login;
import './menu.model.dart' as menu;
import 'connect_server.dart';

class BillPlus {
  int id;
  home.Table table;
  DateTime dateCheckOut;
  double discount;
  double totalPrice;
  login.Account account;

  BillPlus({this.id, this.table, this.dateCheckOut, this.discount, this.totalPrice, this.account});

  BillPlus.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['ID']);
    this.dateCheckOut = DateTime.parse(json['DateCheckOut']);
    this.discount = double.parse(json['Discount']);
    this.totalPrice = double.parse(json['TotalPrice']);

    this.table = home.Table.noneParametter();
    this.table.id = int.parse(json['IDTable']);
    this.table.name = json['Name'];
    this.table.addFoods(Model.instance.getBillDetailByBill(this.id));

    this.account = login.Account.fromJson(json);
  }
}

class Model {
  static Model _instance;

  static Model get instance {
    if (_instance == null) _instance = Model();
    return _instance;
  }

  Future<bool> deleteBill(int id) {
    return MySqlConnection.instance.executeNoneQuery(queries.DELETE_BILL, parameter: [id]);
  }

  Future<List<menu.Food>> getBillDetailByBill(int idBill) async {
    Future<List> futureFoods =
        MySqlConnection.instance.executeQuery(queries.GET_BILLDETAIL_BY_BILL, parameter: [idBill]);
    return parseFood(futureFoods);
  }

  Future<List<BillPlus>> getListBill() async {
    Future<List> futureBills =
        MySqlConnection.instance.executeQuery(queries.GET_BILLS, parameter: [DateTime.now()]);
    return parseBillPlus(futureBills);
  }

  Future<List<BillPlus>> parseBillPlus(Future<List> bills) async {
    List<BillPlus> futureBills = [];
    await bills.then((values) {
      values.forEach((value) {
        futureBills.add(BillPlus.fromJson(value));
      });
    });
    return futureBills;
  }

  Future<List<menu.Food>> parseFood(Future<List> foods) async {
    List<menu.Food> futureFoods = [];
    await foods.then((values) {
      values.forEach((value) {
        futureFoods.add(menu.Food.fromJson(value));
      });
    });
    return futureFoods;
  }
}
